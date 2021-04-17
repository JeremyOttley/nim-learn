type
  Computer = object
    manufacturer: string
    cpu: string
    powerConsumption: float
    ram: int # GB
    ssd: int # GB
    quantity: int
    price: float

var workLaptop = Computer(manufacturer: "Dell", 
                          cpu: "Intel", 
                          powerConsumption: 89.15, 
                          ram: 32, 
                          ssd: 250, 
                          quantity: 1, 
                          price: 1600.00)
                          
echo workLaptop.cpu
echo workLaptop.ssd
echo workLaptop.price
