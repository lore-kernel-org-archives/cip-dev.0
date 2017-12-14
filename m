From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Thu, 14 Dec 2017 14:57:12 +0900
Subject: [cip-dev] B@D: iwg20m support
Message-ID: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Trung-san, Robert and all

I received the AWS credentials from Agustin and uploaded
the cip-core binaries for the Renesas iwg20m board.

https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.cpio.gz
https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/r8a7743-iwg20d-q7.dtb
https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/uImage

You will need to patch the master branch of the B at D git
repository with the next three patches. Please re-install
from the latest code just to make sure we are on the same page.
Robert: please, could you ask Tom to merge them?

[PATCH 1/3] Vagrantfile: support the http proxy plugin
[PATCH 2/3] iwg20m: add device type and dictionary template
[PATCH 3/3] iwg20m: add a test that boots a cip-core ramdisk

Making it work is a bit complicated so I have prepared a guide
for you. Check it below and make sure you don't skip any step or
modify any file without a reason.

Regards,
Daniel

Enabling Renesas board
======================

Prepare your IP Power 9258 PDU
    - Set the password
    - Set the IP address to 192.168.11.68

Virtualbox serial port (ser2net) setup
    host$ sudo apt install virtualbox-ext-pack
    host$ sudo adduser <user> vboxusers
    - Oracle VM Virtualbox manager
        Settings > USB > add the device USB-UART device
        (/dev/ttyUSB1 on the host will become /dev/ttyUSB0 inside the VM)

Prepare network interfaces for tftp and for controlling the remote power switch (PDU)
    host$ vagrant up
    host$ vagrant ssh
    vagrant$ sudo -s
    vagrant# ifconfig eth1:1 192.168.11.76/24 <-- PDU ip: 192.168.11.68
    vagrant# export no_proxy="192.168.11.68, $no_proxy"
    vagrant# curl http://admin:<password>@192.168.11.68/set.cmd?cmd=setpower+p61=1 (switch on)
    vagrant# curl http://admin:<password>@192.168.11.68/set.cmd?cmd=setpower+p61=0 (switch off)

Check ser2net is working
    vagrant# curl http://admin:<password>@192.168.11.68/set.cmd?cmd=setpower+p61=1 (switch on)
    vagrant# telnet localhost 8020
        [IMP] you should be able to see u-boot and kernel messages
        [Note] to quit: Ctrl-] and quit

Prepare the tftp server
    host$ sudo service tftpd-hpa stop <-- to avoid conflicts

Check the status of the device
    - make sure that your device type definitions are updated
        vagrant# less /etc/lava-server/dispatcher-config/device-types/renesas-iwg20m.jinja2 <-- renesas-iwg20m.jinja2
        vagrant# less /etc/lava-server/dispatcher-config/devices/iwg20m01.jinja2 <-- myiwg20m.jinja2
    - check the workers
        vagrant# lava-server manage workers list
            Workers:
                * stretch.localdomain (3 devices) (master) <-- hostname --long
    - check the device list
        vagrant# lava-server manage device-types list
            * beaglebone-black (1 devices)
            * qemu (1 devices)
            * renesas-iwg20m (1 devices)

Changing SERVER_IP so that the target downloads from the proper address
    - SERVER_IP corresponds to the address of the dispatcher
    - LAVA V2 settings
        Ref: https://validation.linaro.org/static//docs/v2/pipeline-admin.html#extra-dispatcher-configuration
        vagrant# cp /usr/share/lava-dispatcher/dispatcher.yaml /etc/lava-server/dispatcher.d/stretch.localdomain.yaml <-- the name of the worker!!
        vagrant# vi /etc/lava-server/dispatcher.d/stretch.localdomain.yaml
            dispatcher_ip: 192.168.1.66
        vagrant# ifconfig eth1:2 192.168.1.66/24
        vagrant# service lava-server restart
        vagrant# service lava-slave restart
        vagrant# service tftpd-hpa restart

Add binaries to the kernel-ci storage server
    host$ cp -rf path/to/binaries board-at-desk-single-dev/
        [Note] The binaries must be as follows (see test definition):
            - iwg20m/r8a7743-iwg20d-q7.dtb (rename from uImage-r8a7743-iwg20d-q7.dtb)
            - iwg20m/uImage
            - iwg20m/core-image-minimal-iwg20m.cpio.gz
        [Note] You can download them from here
            https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/core-image-minimal-iwg20m.cpio.gz
            https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/r8a7743-iwg20d-q7.dtb
            https://s3-us-west-2.amazonaws.com/download.cip-project.org/cip-core/iwg20m/uImage
    host$ cd board-at-desk-single-dev/
    host$ vagrant rsync
    vagrant# cp -r /vagrant/binaries/iwg20m/ /var/www/images/kernel-ci/
    vagrant# ls /var/www/images/kernel-ci/iwg20m/
        core-image-minimal-iwg20m.cpio.gz  r8a7743-iwg20d-q7.dtb  uImage
        [Note] Use http://localhost:8010/iwg20m/ in the tests
    vagrant# service nginx restart

Login into LAVA
    host$ firefox http://localhost:8080/
        lavauser:mylava1234
        Scheduler > Submit job
            - Copy and paste tests/iwg20m-test-ramdisk.yaml
            - It should work as follows:
                + LAVA causes the board to switch on
                + LAVA downloads the kernel/dt/ramdisk from the storage server
                  and overlays necessary LAVA binaries
                + LAVA interrupts u-boot and executes 'run bootcmd'
                + The board downloads the files by TFTPBOOT
                + LAVA detects the login prompt and logs in
                + LAVA detects the shell prompt and executes its test (uname -a)
                + LAVA causes the board to switch off
                (IT WORKS)
