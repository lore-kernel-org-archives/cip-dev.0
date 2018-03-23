From: robert.marshall@codethink.co.uk (Robert Marshall)
Date: Fri, 23 Mar 2018 15:53:30 +0000
Subject: [cip-dev] Progress on the CIP kernel maintenance and testing
	for your ELC talk
In-Reply-To: <CAEss1EJp_mvN66au1VxyMR2Btzz_ZC57V=mhyqT90JFmF2M_=Q@mail.gmail.com>
	(Zoran S.'s message of "Fri, 23 Mar 2018 15:39:48 +0100")
References: <52450414.TvpEuUOuAV@linux-if6s>
	<CAEss1ELvyixTSJcK4OerZJ8qDwf_6kGmVP0Syc0KzSswELhtYA@mail.gmail.com>
	<TY1PR06MB07023674D891E7E86BB52934B7A80@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<CAEss1E+aiDsAkVZmD_Z9AWjCwTvJWWRB3jqNYswUDxvzYMbgNw@mail.gmail.com>
	<87605myilu.fsf@ctlt579.codethink.co.uk>
	<CAEss1EJp_mvN66au1VxyMR2Btzz_ZC57V=mhyqT90JFmF2M_=Q@mail.gmail.com>
Message-ID: <871sgayeit.fsf@ctlt579.codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Zoran

Hi!

Zoran S <zoran.stojsavljevic.de@gmail.com> writes:

> Hello Robert,
>
> The initramfs I use (since I am just about to start talking on the
> YOCTO list why I am failing on ncurses-native-5.9 while building the
> iwg20d YOCTO /Jethro/Morty kas based build) is this one (the Busybox
> generic one):
>
> Creating an initramfs with BusyBox for the Beaglebone Black
> https://wiki.linuxfoundation.org/civilinfrastructureplatform/cipsystembuildhowto
>
> Everything else is true RT-4.4.120-rt13 (zImage and .dtb - both of
> them: the correct rt one, and the old one from ages ago (5 years ago
> generated for kernel 3.2)).
>

Can you update the  #167 ticket with the full settings that you're using
- so device and device-type as well as the health check - or link them to
pastebins and I'll take a look at it when I'm back on Wednesday

Have a good weekend!

Robert

> Zoran
> ______
>
> On Fri, Mar 23, 2018 at 3:25 PM, Robert Marshall
> <robert.marshall@codethink.co.uk> wrote:
>> Zoran,
>>
>> Zoran S <zoran.stojsavljevic.de@gmail.com> writes:
>>
>>> Hello Chris,
>>>
>>> And so li'll I have requested (namely this: console=ttySC0)! It does the magic... It works, man! Works with:
>>> uname -a
>>> Linux 192.168.15.189 4.4.120-cip20-rt13-dirty #2 SMP Tue Mar 13 15:21:30 GMT 2018 armv7l GNU/Linux
>>>
>>> Within one day I set the whole iwg2x device type and iwg20m device forU-Boot and Lava V2:
>>> vagrant at stretch:~$ dpkg -l lava-server lava-dispatcher
>>> ||/ Name                    Version          Architecture     Description
>>> +++-=======================-================-================-===================================================
>>>
>>> ii  lava-dispatcher         2018.2.post2-1+s amd64            Linaro Automated Validation Architecture dispatcher
>>> ii  lava-server             2018.2-1+stretch all              Linaro Automated Validation Architecture server
>>> vagrant at stretch:~$
>>>
>>> And I missed the one very small step for me, but very big for my Alter Ego Confidence... ;-)
>>>
>>> And, yes, I did NOT try it with U-Boot, I went straight to VBox VM, to Lava 2018.2 and set all the ingredients (3 of them) in the iwg2x device
>>> type definition, namely in iwg2x.jinja2:
>>>
>>> {% set console_device = console_device|default('ttySC0') %}
>>> {% set baud_rate = baud_rate|default(115200) %}
>>> {% set device_type = "iwg2x" %}
>>> {% set bootm_kernel_addr = '0x40007fc0' %}
>>> {% set bootm_ramdisk_addr = '0x41000000' %}
>>> {% set bootm_dtb_addr = '0x40f00000' %}
>>> {% set bootm_low = '0x41e00000' %}
>>> {% set bootm_size = '0x1000000' %}
>>> ...
>>>
>>> It works (with difficulties) with the natively generated r8a7743-iwg20d-q7.dtb'.
>>>
>>> Filename '149/tftp-deploy-rkMXw2/dtb/r8a7743-iwg20d-q7.dtb'.
>>> Load address: 0x40f00000
>>> Loading: * T ##
>>>      3.9 KiB/s
>>> done
>>> Bytes transferred = 24725 (6095 hex)
>>> ## Loading init Ramdisk from Legacy Image at 41000000 ...
>>>    Image Name:
>>>    Image Type:   ARM Linux RAMDisk Image (uncompressed)
>>>    Data Size:    5861271 Bytes = 5.6 MiB
>>>    Load Address: 00000000
>>>    Entry Point:  00000000
>>> ## Flattened Device Tree blob at 40f00000
>>>    Booting using the fdt blob at 0x40f00000
>>>    Using Device Tree in place at 40f00000, end 40f09094
>>> Unable to update property <NULL>:mac-address, err=FDT_ERR_BADPATH
>>> Unable to update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH
>>> Unable to update property /iwg20m_q7_common:vin2-ov5640, err=FDT_ERR_NOTFOUND
>>> Starting kernel ...
>>>
>>> Wow! Now, I am for last few days (few hours per day) trying (very unsuccessfully, sorry) to set Daniel's Sangorrin's: kas build
>>> kas-iwg20m.yml in my Vbox Fedora 24 generated environment, since I desperately need TRUE initramfs in order to make iwg20m rt-tests
>>> with cyclic (hackbench assisting in there)!
>>>
>>> Here is the log of the native Lava shell test commands (the most important is uname -a):
>>> https://pastebin.com/LKfJs4mn
>>>
>>> Here is the iwg20m smoking test log:
>>> https://pastebin.com/PWy4xWpG
>>>
>>> I guess, Robert/Agustin Benito, we should close CIP testing issue #167, shouldn't we? ;-)
>>>
>>
>> Let me see if I can replicate your success first. Thanks to both for the
>> pointers!
>>
>> Robert
>>
>>> Have all nice weekend!
>>> Zoran
>>> _______
>>>
>>> On Fri, Mar 23, 2018 at 11:55 AM, Chris Paterson <Chris.Paterson2@renesas.com> wrote:
>>>
>>>  Hello Zoran,
>>>
>>>
>>>
>>>  Sorry for the slow response.
>>>
>>>
>>>
>>>  Could you try setting the following in u-boot?
>>>
>>>
>>>
>>>  setenv bootm_low '0x41e00000'
>>>
>>>  setenv bootm_size '0x1000000'
>>>
>>>
>>>
>>>
>>>
>>>  Looking at https://pastebin.com/AjRdTZKx, line 268, you are setting:
>>>
>>>  setenv bootargs 'console=ttyO0,115200n8 root=/dev/ram0  ip=dhcp';
>>>
>>>
>>>
>>>  I?m guessing the console should be set to ttySC0.
>>>
>>>
>>>
>>>
>>>
>>>  If you still see no output from the Kernel, have you tried enabling low-level debugging?
>>>
>>>
>>>
>>>  CONFIG_DEBUG_LL, CONFIG_DEBUG_RCAR_GEN2_SCIF0, CONFIG_EARLY_PRINTK
>>>
>>>
>>>
>>>
>>>
>>>  Kind regards, Chris
>>>
>>>
>>>
>>>  From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Zoran S
>>>  Sent: 13 March 2018 16:26
>>>  To: Agustin Benito Bethencourt Codethink <agustin.benito@codethink.co.uk>
>>>  Cc: cip-dev at lists.cip-project.org
>>>  Subject: Re: [cip-dev] Progress on the CIP kernel maintenance and testing for your ELC talk
>>>
>>>
>>>
>>>  Hello Augustin,
>>>
>>>  I have update on iwg20m... Straight to the newest kernel 4.4.120-cip20-rt13! ;-)
>>>
>>>
>>>
>>>  You write:
>>>
>>>  > Work in progress to support Renesas iw20gm in B at D in the coming weeks.
>>>  > Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167
>>>
>>>  I spent today whole day home alone to play with board (called iW-RainboW-G20D), based on iwg20m which was given to me by Jan
>>>  (Kiszka).
>>>
>>>  It has RENESAS r8a7743 (armv7h, if I am not mistaken), and it is quite an interesting board, I must admit).
>>>
>>>  The task: make it compliant with CIP VM Lava testing in one (1) one single day, since I do not have too much experience with this
>>>  board.
>>>
>>>  This one is initial which was used by Lava 2017.7 bring-up.
>>>
>>>  I was able today to do the following:
>>>
>>>  [1] Add passthrough to the Vagrantfile, so I can have iwg20m ser2net on the VM;
>>>
>>>  [2] Create the new device-type in Lava: /etc/lava-server/dispatcher-config/device-types/iwg2x.jinja
>>>
>>>  [3] Add this device type to Lava using Django management, with several tests to see how the device type iwg2x behaves;
>>>
>>>  [4] Add the concrete device to device type: /etc/lava-server/dispatcher-config/devices/iwg20m.jinja;
>>>
>>>  [5] Handled/prepared the newest kernel CIP 4.4.120-cip20 (released last week, by Daniel Wagner);
>>>
>>>       v4.4.120-cip20-iwg20m/v4.4.120-cip20-rt13
>>>       https://pastebin.com/gv0cg3PD
>>>
>>>
>>>
>>>  Now, after some triages, and some .jinja2 fixes, some u-boot adjustments in the device-type script, I was able to run the Lava .yaml
>>>  test on raminitfs.
>>>
>>>  It behaves correctly (local/private network is the problem here) till it needs to start kernel, which it tftp-ed correctly from
>>>  localhost://8010 --- where kernel ingredients are located.
>>>
>>>  But, it fails since it looses a mac/physical address, it seems. So, something is not correct with ETH100/ETH1000 driver, since I see these
>>>  problems popping up again, and again, and again... But my dhcpd daemon is very robust, and it keeps pounding/adding lost address to
>>>  the ETH on Renesas board.
>>>
>>>  The .yaml test I am running to test this board is here: job_name:
>>>  local test of ramdisk test on iwg20
>>>  https://pastebin.com/8ngYQzha
>>>
>>>
>>>
>>>  And the Lava initramfs test results are captured here: https://pastebin.com/AjRdTZKx
>>>
>>>  Please, note the point of failure:
>>>
>>>  ## Flattened Device Tree blob at 40f00000
>>>
>>>     Booting using the fdt blob at 0x40f00000
>>>
>>>     Using Device Tree in place at 40f00000, end 40f09094
>>>
>>>  Unable to update property <NULL>:mac-address, err=FDT_ERR_BADPATH
>>>
>>>  Unable to update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH
>>>
>>>  Unable to update property /iwg20m_q7_common:vin2-ov5640, err=FDT_ERR_NOTFOUND
>>>
>>>  Starting kernel ...
>>>
>>>  end: 2.4.3 bootloader-commands (duration 00:00:58) [common]
>>>
>>>  start: 2.4.4 auto-login-action (timeout 00:04:00) [common]
>>>
>>>  boot_message is being deprecated in favour of kernel-start-message in constants
>>>
>>>  auto-login-action: Wait for prompt ['Booting Linux', 'Resetting CPU', 'Must RESET board to recover', 'TIMEOUT', 'Retry count
>>>  exceeded', 'ERROR: The remote end did not respond in time.'] (timeout 00:05:00)
>>>
>>>  auto-login-action timed out after 240 seconds
>>>
>>>  Any guidance/help from Renesas people and others on The Far East using this iwg20m technology is appreciated and welcome!
>>>
>>>  Thank you,
>>>
>>>  Zoran Stojsavljevic
>>>
>>>  _______
>>>
>>>  On Tue, Mar 13, 2018 at 3:58 PM, Agust?n Benito Bethencourt <agustin.benito@codethink.co.uk> wrote:
>>>
>>>  Hi Yoshi,
>>>
>>>  since you usually provide an update of the technical work done within CIP in
>>>  your talks, here are some bullet points you can add in tomorrow's talk at ELC
>>>  if you like.
>>>
>>>  ## Kernel maintenance
>>>
>>>  * CIP 4.4.120-cip20 released last week.
>>>
>>>  Link: https://gitlab.com/cip-project/linux-cip
>>>
>>>  Comment: Ben Hutchings, from Codethink, releases a kernel version every 4 to 6
>>>  weeks approx., depending on the amount and relevance of upstream patches
>>>  landing on 4.4 LTS. Ben H. collaborates in the 4.4 LTS process directly.
>>>
>>>  * Effort in ensuring Meltdown and Spectre fixes land in the CIP kernel and CIP
>>>  Members are informed about the current situation.
>>>
>>>  * Review of platform specific backported patches, specially from Renesas
>>>  platforms.
>>>
>>>  Comment: Renesas backports patches to 4.4 from mainline that are reviewed and
>>>  merged into CIP kernel when appropriate.
>>>
>>>  * CIP 4.4.120-cip120-rt13 released
>>>
>>>  Link: git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git
>>>
>>>  Comment: I would name Daniel Wagner, Siemens, as maintainer and say a few
>>>  words about the release process if you have time.
>>>
>>>  ## Kernel testing
>>>
>>>  * B at D is being updated to include the latest kernelci
>>>
>>>  Link: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/
>>>  merge_requests/53
>>>
>>>  * Work in progress to support Renesas iw20gm in B at D in the coming weeks.
>>>
>>>  Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167
>>>
>>>  * Improvements in networking and Vagrant configurations.
>>>
>>>  * Next steps: deployment through containers.
>>>
>>>  * B at D description and deploy.
>>>
>>>  Description: https://wiki.linuxfoundation.org/civilinfrastructureplatform/
>>>  ciptestingboardatdesksingledevfeaturepage
>>>
>>>  Deploy: https://wiki.linuxfoundation.org/civilinfrastructureplatform/
>>>  ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-
>>>  from-scratch-using-vagrant-15
>>>
>>>  Any additional feedback from participants on this list is welcome.
>>>
>>>  Best Regards
>>>  --
>>>  Agust?n Benito Bethencourt
>>>  Principal Consultant
>>>  Codethink Ltd
>>>  _______________________________________________
>>>  cip-dev mailing list
>>>  cip-dev at lists.cip-project.org
>>>  https://lists.cip-project.org/mailman/listinfo/cip-dev
>>>
>>> _______________________________________________
>>> cip-dev mailing list
>>> cip-dev at lists.cip-project.org
>>> https://lists.cip-project.org/mailman/listinfo/cip-dev
