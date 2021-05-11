#! /bin/bash
sudo apt-get update
sudo apt-get install -y apache2
sudo systemctl start apache2
sudo systemctl enable apache2
echo -e '<html>\n\t<body style="background-color:orange;">\n\t\t<h1 style="text-align:center">MultiCloud Demo AWS with AVI GSLB</h1>\n\t\t<p align="center"><a href="https://www.vmware.com/ca/products/nsx-advanced-load-balancer.html"> More on NSX Advanced Load Balancing (AVI Networks) </a></p>\n\t\t</body>\n</html>' | sudo tee /var/www/html/index.html