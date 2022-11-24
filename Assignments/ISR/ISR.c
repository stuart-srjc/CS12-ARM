#include <linux/init.h>
#include <linux/module.h>
#include <linux/interrupt.h>
#include <linux/gpio.h>

#define GPIO_20 20 // pin 38

MODULE_LICENSE("GPL");

char device[] = "ISR_Test";

static irqreturn_t gpio_isr(int irq,void *dev_id) {
    printk(KERN_INFO "KLM: Interupt Hanled.");
    return IRQ_HANDLED;
    }


static int __init isr_init(void){   
    int ret = 0;
    int irq = 0;
    printk(KERN_INFO "KLM: Registering GPIO...");

    // register GPIO PIN in use
    ret = gpio_is_valid(GPIO_20);
    if (!ret) {
        printk(KERN_ERR "KLM - Unable to validate GPIO for RX: %d\n", ret);
        goto end;
    }
    
    //Requesting the GPIO
    ret = gpio_request(GPIO_20,"GPIO_20"); 
    if (ret){
        printk(KERN_ERR "KLM - Unable to request GPIO for RX: %d\n", ret);
        goto end;
    }

    // Configure GPIO as input
    gpio_direction_input(GPIO_20);

    // debounce GPIO
    ret = gpio_set_debounce(GPIO_20, 200);
    if (!ret){
        printk(KERN_ERR "KLM - Unable to set debounce GPIO: %d\n", ret);
        goto end;
    }

    printk(KERN_INFO "KLM: GPIO Registered...");
    
    printk(KERN_INFO "KLM: Registering ISR...");
   
    //Requesting the IRQ
    irq = gpio_to_irq(GPIO_20);
    ret = request_irq(irq,                  //IRQ number
                  (void *)gpio_isr,         //IRQ handler
                  IRQF_NO_SUSPEND || IRQF_TRIGGER_RISING,      //Handler will be called in raising edge
                  "gpio_20",                //used to identify the device name using this IRQ
                  (void*)device);                 //device id for shared IRQ
    if (ret){
        printk(KERN_ERR "KLM - Unable to request IRQ: %d\n", ret);
        goto end;
    }
       
    
    printk(KERN_INFO "KLM: ISR Registered...");
   return ret;
   
end:
    if (ret) {
        gpio_free(GPIO_20);
    }
    
    return ret;    

    
}



static void __exit isr_exit(void){
    int irq=0;
    printk(KERN_INFO "KLM: stopping...");
   
    irq = gpio_to_irq(GPIO_20);
    free_irq(irq, (void*)device);
    gpio_free(GPIO_20);

    printk(KERN_INFO "KLM: stopping done.");
}



module_init(isr_init);
module_exit(isr_exit);
