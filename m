From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Wed, 19 Jul 2017 13:01:13 +0100
Subject: [cip-dev] Procedure to use B@D in Windows 10
Message-ID: <87o9sg1vqu.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

The 0.9.1 release box of B at D has been successfully imported into Windows
10 and both a QEMU and BBB health check have been run on that virtual machine.
This setup also works when provisioning a box from a clone of the git repository.

The steps to get B at D running on Windows 10 are as follows:

- Install the guest additions `vagrant plugin install vagrant-vbguest`
- Install rsync/ssh/git in cygwin.
- core.autocrlf=input is needed in the git settings for the scripts to
    run under the Debian of the virtual machine.
- Once the vm is up then in virtualbox add a USB filter for the FTDI device.
- For kernelci access you need to use either Firefox or Chrome - the Microsoft
    browsers will not work.
- You may need the vagrant scp command (if you wish to copy other files
   onto the VM) if so -
    vagrant plugin install vagrant-scp
- setup mybbb.dat to use the IP address of the VM rather than that of
    the host.

The wiki has been updated to document these steps.

Robert
