X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web11.8127.1643889468387582181
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Feb 2022 03:57:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1 header.b=BeLPPYpE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20220203115743a11c7fdd632ca09209-ajmdyo@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20220203115743a11c7fdd632ca09209
        for <cip-dev@lists.cip-project.org>;
        Thu, 03 Feb 2022 12:57:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dGHoWf7DdsbvCWCMSguYQyHWkQyplst5ZFHqs5swx7g=;
 b=BeLPPYpE7pi/IftVHuLD+r1qYnwj5OqnZhA3NYKBVc1/6HXoTqKMc2OKERDSQAY5UTKrtj
 RpHZqeW3xBN0Nubw5bCvSKXkHHUNQ9rdWp8ALoZC8GxiiKY7sRwgx2xLfsuKhUWf6uiF+fYz
 mOH3axQqtu4f6vyb4gME0Z/kAzL8A=;
Message-ID: <f80fdf3d-816f-2497-0bd3-89e5355977fc@siemens.com>
Date: Thu, 3 Feb 2022 12:57:42 +0100
MIME-Version: 1.0
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 jan.kiszka@siemens.com
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
 akihiro27.suzuki@toshiba.co.jp
References: <52fae1ea-25fc-e692-2b51-e503681d2efb@siemens.com>
 <20220201153502.14230-3-Shivanand.Kunijadar@toshiba-tsip.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [isar-cip-core v2 2/2] README.swupdate.md: add readme file with steps to verify swupdate
In-Reply-To: <20220201153502.14230-3-Shivanand.Kunijadar@toshiba-tsip.com>
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"; format="flowed"
List-Id: <cip-dev.lists.cip-project.org>

Hi,

On 2/1/22 16:35, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Prepare readme file with necessary steps to verify swupdate feature
> with rollback functionality.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>   doc/README.swupdate.md | 208 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 208 insertions(+)
>   create mode 100644 doc/README.swupdate.md
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> new file mode 100644
> index 0000000..56bc77c
> --- /dev/null
> +++ b/doc/README.swupdate.md
> @@ -0,0 +1,208 @@
> +
> +Clone the isar-cip-core repository
> +```
> +host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
> +```
> +
> +Install `kas-container` from the [kas project](https://github.com/siemens/kas):
> +
> +```
> +host$ wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-container
> +host$ chmod a+x kas-container
> +```
> +
> +Build the image for swupdate
> +
> +```
> +host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml

Would it be better to use ./kas-container menu?

> +```
> +- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
> +- modify the image for example add a new version to the image by adding PV=2.0.0 to cip-core-image.bb
> +- rebuild the image using above command and start the new target
> +```
> +host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +
> +Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder to the running system
> +
> +```
> +root@demo:~# scp <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
> +```

According to https://wiki.qemu.org/Documentation/Networking the default 
host ip should be 10.0.2.2.
> +
> +Check which partition is booted, e.g. with lsblk:
> +
> +```
> +root@demo:~# lsblk
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> +sda      8:0    0    2G  0 disk
> +├─sda1   8:1    0 16.4M  0 part
> +├─sda2   8:2    0   32M  0 part
> +├─sda3   8:3    0   32M  0 part
> +├─sda4   8:4    0 1000M  0 part /
> +└─sda5   8:5    0 1000M  0 part
> +```
> +
> +Apply swupdate and reboot
> +```
> +root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +root@demo:~# reboot
> +```
> +Check which partition is booted, e.g. with lsblk and the rootfs should have changed
> +```
> +root@demo:~# lsblk
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> +sda      8:0    0    2G  0 disk
> +├─sda1   8:1    0 16.4M  0 part
> +├─sda2   8:2    0   32M  0 part
> +├─sda3   8:3    0   32M  0 part
> +├─sda4   8:4    0 1000M  0 part
> +└─sda5   8:5    0 1000M  0 part /
> +```
> +
> +Check bootloader ustate after swupdate
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> +Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
> +kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +
> +----------------------------
> + Config Partition #1 Values:
> +in_progress:      no
> +revision:         3
> +kernel:           C:BOOT1:vmlinuz
> +kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           2 (TESTING)
> +```
> +
> +if Partition #1 usate is 2 (TESTING) then execute below command to confirm swupdate and the command will set ustate to "OK"
> +```
> +root@demo:~# bg_setenv -c
> +```
> +
> +# swupdate rollback example
> +
> +Build the image for swupdate with service which causes kernel panic during system boot using below command.
> +
> +```
> +host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
> +```
> +- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
> +- build the image again without `kernel-panic.yml` recipe using below command
> +```
> +host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
> +```
> +
> +Start the target on QEMU
> +```
> +host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
> +```
> +
> +Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder to the running system
> +
> +```
> +root@demo:~# scp <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-image-cip-core-buster-qemu-amd64.swu .
> +```
> +
> +Check which partition is booted, e.g. with lsblk:
> +
> +```
> +root@demo:~# lsblk
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> +sda      8:0    0    2G  0 disk
> +├─sda1   8:1    0 16.4M  0 part
> +├─sda2   8:2    0   32M  0 part
> +├─sda3   8:3    0   32M  0 part
> +├─sda4   8:4    0 1000M  0 part /
> +└─sda5   8:5    0 1000M  0 part
> +```
> +
> +Check bootloader ustate before swupdate and should be as below
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> +Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
> +kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +----------------------------
> +Config Partition #1 Values:
> +in_progress:      no
> +revision:         1
> +kernel:           C:BOOT1:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
> +kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK > +```
> +
> +Apply swupdate as below
> +```
> +root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +```
> +
> +check bootloader ustate after swupdate. if the swupdate is successful then **revision number** should increase to **3** and status should be changed to **INSTALLED** for Partition #1.
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> +Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
> +kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +----------------------------
> +Config Partition #1 Values:
> +in_progress:      no
> +revision:         3
> +kernel:           C:BOOT1:vmlinuz
> +kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           1 (INSTALLED)
> +```
> +
> +Execute reboot command
> +- reboot command should cause kernel panic error.
> +- watchdog timer should expire and restart the qemu. bootloader should select previous partition to boot.
> +```
> +root@demo:~# reboot
> +```
> +
> +Once the system is restarted, check the bootloader ustate
> +- if update is failed then **revision number** should reduce to **0** and status should change to **FAILED** for Partition #1.
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> + Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmlinuz
> +kernelargs:       console=tty0 console=ttyS0,115200 rootwait earlyprintk root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000001 rw initrd=cip-core-image-cip-corg
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +----------------------------
> + Config Partition #1 Values:
> +in_progress:      no
> +revision:         0
> +kernel:           C:BOOT1:vmlinuz
> +kernelargs:       root=PARTUUID=fedcba98-7654-3210-cafe-5e0710000002 console=tty0 console=ttyS0,115200 rootwait earlyprintk rw initrd=cip-core-image-cip-corg
> +watchdog timeout: 60 seconds
> +ustate:           3 (FAILED)
> +```

Quirin


