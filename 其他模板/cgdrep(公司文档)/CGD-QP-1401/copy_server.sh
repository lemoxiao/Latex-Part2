make
sudo mv main.pdf /home/public/document/procedure/CGD-QP-1401/CGD-QP-1401.pdf
make clean
cd ../
tar -czvf CGD-QP-1401.tar.gz CGD-QP-1401
sudo mv CGD-QP-1401.tar.gz /home/public/document/procedure/CGD-QP-1401/ && echo done
