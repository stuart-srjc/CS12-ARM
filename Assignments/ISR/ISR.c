// Include the files needed for:
#include <linux/init.h>         // KLM
#include <linux/module.h>       // KLM
#include <linux/interrupt.h>    // Interrupts
#include <linux/gpio.h>         // GPIO

#define GPIO_20 20 // pin 38

MODULE_LICENSE("GPL");          // licenses are ... complicated, let us just use GPL

char device[] = "ISR_Test";     // create a string, not terminated by zero

/* gpio_isr 
 *  parameters:     irq, the irq that triggered this interupt service routine
 *                  dev_id void pointer to the device id of the device that triggered the interrupt 
 *  Preconditions:  An irq has been triggered, and valid values are in irq and dev_id
 *  Postconditions: the message "KLM: Interupt Handled." has been printed to /var/log/syslog
 *  Return:         IRQ_HANDLED, informing the OS that the interupt has been handled
 */
static irqreturn_t gpio_isr(int irq,void *dev_id) {
    printk(KERN_INFO "KLM: Interupt Handled.");
    return IRQ_HANDLED;
    }

/*  isr_init
 *  parameters:     None 
 *  Preconditions:  The KLM has been requested to load
 *  Postconditions: The GPIO Pin is:
 *                      tested for validity
 *                      requested for use
 *                      configured as input
 *                      debounce is set to 200 
 *                  The IRQ is requested                  
 *                  Appropriate messages have been loged for success of failure
 *  Return:         void
 */
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
    
/* isr_exit 
 *  parameters:     None 
 *  Preconditions:  
 *  Postconditions: IRQ is freed 
 *                  GPIO if freed
 *  Return:         void 
 */
static void __exit isr_exit(void){
    int irq=0;
    printk(KERN_INFO "KLM: stopping...");
   
    irq = gpio_to_irq(GPIO_20);
    free_irq(irq, (void*)device);
    gpio_free(GPIO_20);

    printk(KERN_INFO "KLM: stopping done.");
}


// Register the Init and Exit routintes for the KLM
module_init(isr_init);
module_exit(isr_exit);
