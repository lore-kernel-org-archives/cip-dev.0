From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 13 Jul 2018 11:23:37 +0100
Subject: [cip-dev] [CIP testing strategy] Vagrant disksize plugin
	introduced, and some other (Vagrant-less) ideas
In-Reply-To: <CAEss1ELeFbS2zc6sxtUtCKWs+evBAzWepHEM5F-RtefipZ1d1w@mail.gmail.com>
	(Zoran S.'s message of "Mon, 2 Jul 2018 08:33:51 +0200")
References: <CAEss1ELeFbS2zc6sxtUtCKWs+evBAzWepHEM5F-RtefipZ1d1w@mail.gmail.com>
Message-ID: <871sc7v3h2.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Zoran

Thanks for alerting me to this I'll take a look!

Robert

Zoran S <zoran.stojsavljevic.de@gmail.com> writes:

> Hello CIP members,
>
> Recently, I have learned that vagrant disksize plugin was introduced.
> https://github.com/sprotheroe/vagrant-disksize
>
> This, actually, replaces two native VBox commands (example given below):
>
>   VBoxManage clonehd stretch.vmdk stretch.vdi --format VDI --variant Standard
>   VBoxManage modifyhd stretch.vdi --resize 81920
>
> The disksize plugin creates .VDI type of virtual HDD with the
> stretched virtual size of 80GB (default .VMDK has limited 10GB size).
>
> Please, do note that third party tool is required to extend the actual
> virtual disk limit (as tool example: gparted).
>
> In Vagrant file, you could create/add some code like this:
>
> if !Vagrant.has_plugin?("vagrant-disksize")
>    system('vagrant plugin install vagrant-disksize');
> end
>
> Vagrant.configure(2) do |config|
>   config.vm.provider :virtualbox do |vbox, override|
>     config.vm.box = "debian/stretch64"
>     config.disksize.size = '80GB'
>
>     vbox.customize ["modifyvm", :id, "--vram", "32"]
>     vbox.customize ["modifyvm", :id, "--memory", "4096"]
>     vbox.customize ["modifyvm", :id, "--cpus", "4"]
>     vbox.customize ["modifyvm", :id, "--firmware", "bios"]
>     vbox.customize ["modifyvm", :id, "--acpi", "on"]
>     vbox.customize ["modifyvm", :id, "--ioapic", "on"]
>     vbox.customize ["modifyvm", :id, "--cpuexecutioncap", "75"]
>     vbox.customize ["modifyvm", :id, "--rtcuseutc", "on"]
>     vbox.customize ["modifyvm", :id, "--cpuhotplug", "on"]
>     vbox.customize ["modifyvm", :id, "--pae", "on"]
>     vbox.customize ["modifyvm", :id, "--hwvirtex", "on"]
>     vbox.customize ["modifyvm", :id, "--accelerate3d", "on"]
>     vbox.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
>     vbox.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
>     vbox.customize ["modifyvm", :id, "--usb", "on"]
>     vbox.customize ["modifyvm", :id, "--usbehci", "on"]
>     ...
> _______
>
> I also created [1] VBox VMM configuration and [2] Debian Stretch VM
> configuration stages with pre-seed script (both stages execute with
> one single command respectively), but [3] Lava VM test machine
> creation without Vagrant assistance failed!
>
> In other words I was not able to create [3] Lava VM provisioning stage
> (in my first Vagrant-less attempt), using blindly unchanged CIP test
> integration scripts.
>
> I need to revisit integration scripts, my best guess. But I'll
> continue to work on Vagrant-less test strategy, as my time allows
> (engaged in several other projects).
>
> Thank you,
> Zoran
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
