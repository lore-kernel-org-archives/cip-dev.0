From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Thu, 14 Mar 2019 07:26:50 +0000
Subject: [cip-dev] CIP IRC weekly meeting today
In-Reply-To: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
References: <HK0PR01MB297958B4B49D80F30DD800D9E24B0@HK0PR01MB2979.apcprd01.prod.exchangelabs.com>
Message-ID: <OSAPR01MB37633BA45B40D16877229C51D04B0@OSAPR01MB3763.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello SZ,

I can't attend today. I will write here a few updates

- I have added usbutils to CIP Core (Deby) for Patryk to use lsusb in his tests
   - it seems to work fine now: https://lava.ciplatform.org/scheduler/job/725
   - here is the YAML I used to test pwd, uname and lsusb. Anyone with an account can use it by clicking on "Resubmit" and optionally change the test: https://lava.ciplatform.org/scheduler/job/725/definition

- Suzuki-san has found a couple of issues in ISAR CIP Core.
  - when building ISAR for the beaglebone black it complains that "/debootstrap/debootstrap is not found" (or something like that). He will post a new issue on the Gitlab web page with the complete log.
  - after building ISAR for qemu succesfully, he tried to run start-qemu.sh x86_64 and there was an issue with --nographics that required to add ttyS0 (or something like that) to the qemu parameters. He will be sending a patch soon.
[Note] we are planning to develop the SWUpdate demo using ISAR, any advice or news about how to build SWUpdate on ISAR with the right U-Boot environment?

- Regarding SWUpdate we hit an issue that we had not expected before. Suzuki-san was trying to update the standard BBB debian image (or a yocto-made one), but there were many warnings about orphan nodes etc. After some investigation the reason seems to be that the rootfs is modified during the first boot (or something like that). This is probably one of the biggest problems with updating images instead of files.

# Sorry for the "something like that"s, I have not verified by myself everything

#action I have to upload to the wiki the SW updates tool comparison document
#action Mae please add a link to the SW updates wiki page from the embedded world CIP release page
https://www.linuxfoundation.org/press-release/2019/02/civil-infrastructure-platform-announces-new-super-long-term-support-kernel-that-advances-automation-machine-learning-and-artificial-intelligence/

Thanks,
Daniel

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> On Behalf Of SZ Lin (?
> ??)
> Sent: Thursday, March 14, 2019 10:55 AM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] CIP IRC weekly meeting today
> 
> Hi all,
> 
> Kindly be reminded to attend the weekly meeting through IRC to discuss technical topics with CIP kernel today.
> 
> *Please note that IRC meeting was rescheduled to 18:00 (JST) starting from the first week of Nov. according to
> F2F meeting discussion in ELCE.*
> 
> US-West US-East? UK??? DE???? TW???? JP
> 02:00??? 05:00?? 09:00?? 10:00?? 17:00?? 18:00
> 
> Channel:
> * irc:chat.freenode.net:6667/cip
> 
> Agenda:
> 
> * AI review
> #action Iwamatsu-san will create a template page and send the link via mailing list afterward
> #action Please send configuration file of kernel 4.19 to cip-dev before end of March.
> 
> * Kernel maintenance updates
> * Kernel testing
> * CIP Core
> * Software update
> * AOB
> 
> The meeting will take 30 min although it can be extended to an hour if it makes sense and those involved in the
> topics can stay. Otherwise, the topic will be taken offline or in the next meeting.
> 
> Best regards,
> 
> SZ Lin, Moxa.
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
