From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Tue, 13 Mar 2018 17:26:19 +0100
Subject: [cip-dev] Progress on the CIP kernel maintenance and testing
 for your ELC talk
In-Reply-To: <52450414.TvpEuUOuAV@linux-if6s>
References: <52450414.TvpEuUOuAV@linux-if6s>
Message-ID: <CAEss1ELvyixTSJcK4OerZJ8qDwf_6kGmVP0Syc0KzSswELhtYA@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Augustin,

I have update on iwg20m... Straight to the newest kernel
4.4.120-cip20-rt13! ;-)

You write:

> Work in progress to support Renesas iw20gm in B at D in the coming weeks.
> Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167

I spent today whole day home alone to play with board (called
iW-RainboW-G20D), based on iwg20m which was given to me by Jan (Kiszka).

It has RENESAS r8a7743 (armv7h, if I am not mistaken), and it is quite an
interesting board, I must admit).

The task: make it compliant with CIP VM Lava testing in one (1) one single
day, since I do not have too much experience with this board.

This one is initial which was used by Lava 2017.7 bring-up.

I was able today to do the following:
[1] Add passthrough to the Vagrantfile, so I can have iwg20m ser2net on the
VM;
[2] Create the new device-type in Lava: /etc/lava-server/dispatcher-
config/device-types/iwg2x.jinja
[3] Add this device type to Lava using Django management, with several
tests to see how the device type iwg2x behaves;
[4] Add the concrete device to device type: /etc/lava-server/dispatcher-
config/devices/iwg20m.jinja;
[5] Handled/prepared the newest kernel CIP 4.4.120-cip20 (released last
week, by Daniel Wagner);
     v4.4.120-cip20-iwg20m/v4.4.120-cip20-rt13
     https://pastebin.com/gv0cg3PD

Now, after some triages, and some .jinja2 fixes, some u-boot adjustments in
the device-type script, I was able to run the Lava .yaml test on raminitfs.

It behaves correctly (local/private network is the problem here) till it
needs to start kernel, which it tftp-ed correctly from localhost://8010 ---
where kernel ingredients are located.

But, it fails since it looses a mac/physical address, it seems. So,
something is not correct with ETH100/ETH1000 driver, since I see these
problems popping up again, and again, and again... But my dhcpd daemon is
very robust, and it keeps pounding/adding lost address to the ETH on
Renesas board.

The .yaml test I am running to test this board is here: job_name:
local test of ramdisk test on iwg20
https://pastebin.com/8ngYQzha

And the Lava initramfs test results are captured here:
https://pastebin.com/AjRdTZKx

Please, note the point of failure:

## Flattened Device Tree blob at 40f00000
   Booting using the fdt blob at 0x40f00000
   Using Device Tree in place at 40f00000, end 40f09094
*Unable to update property <NULL>:mac-address, err=FDT_ERR_BADPATH*
*Unable to update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH*
*Unable to update property /iwg20m_q7_common:vin2-ov5640,
err=FDT_ERR_NOTFOUND*
*Starting kernel ...*
end: 2.4.3 bootloader-commands (duration 00:00:58) [common]
start: 2.4.4 auto-login-action (timeout 00:04:00) [common]
boot_message is being deprecated in favour of kernel-start-message in
constants
auto-login-action: Wait for prompt ['Booting Linux', 'Resetting CPU', *'Must
RESET board to recover', 'TIMEOUT', 'Retry count exceeded', 'ERROR: The
remote end did not respond in time.'] *(timeout 00:05:00)
auto-login-action timed out after 240 seconds

Any guidance/help from Renesas people and others on The Far East using this
iwg20m technology is appreciated and welcome!

Thank you,
Zoran Stojsavljevic
_______
On Tue, Mar 13, 2018 at 3:58 PM, Agust?n Benito Bethencourt <
agustin.benito@codethink.co.uk> wrote:

> Hi Yoshi,
>
> since you usually provide an update of the technical work done within CIP
> in
> your talks, here are some bullet points you can add in tomorrow's talk at
> ELC
> if you like.
>
> ## Kernel maintenance
>
> * CIP 4.4.120-cip20 released last week.
>
> Link: https://gitlab.com/cip-project/linux-cip
>
> Comment: Ben Hutchings, from Codethink, releases a kernel version every 4
> to 6
> weeks approx., depending on the amount and relevance of upstream patches
> landing on 4.4 LTS. Ben H. collaborates in the 4.4 LTS process directly.
>
> * Effort in ensuring Meltdown and Spectre fixes land in the CIP kernel and
> CIP
> Members are informed about the current situation.
>
> * Review of platform specific backported patches, specially from Renesas
> platforms.
>
> Comment: Renesas backports patches to 4.4 from mainline that are reviewed
> and
> merged into CIP kernel when appropriate.
>
> * CIP 4.4.120-cip120-rt13 released
>
> Link: git://git.kernel.org/pub/scm/linux/kernel/git/wagi/linux-cip-rt.git
>
> Comment: I would name Daniel Wagner, Siemens, as maintainer and say a few
> words about the release process if you have time.
>
> ## Kernel testing
>
> * B at D is being updated to include the latest kernelci
>
> Link: https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/
> merge_requests/53
> <https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/merge_requests/53>
>
> * Work in progress to support Renesas iw20gm in B at D in the coming weeks.
>
> Link: https://gitlab.com/cip-project/cip-testing/testing/issues/167
>
> * Improvements in networking and Vagrant configurations.
>
> * Next steps: deployment through containers.
>
> * B at D description and deploy.
>
> Description: https://wiki.linuxfoundation.org/civilinfrastructureplatform/
> ciptestingboardatdesksingledevfeaturepage
>
> Deploy: https://wiki.linuxfoundation.org/civilinfrastructureplatform/
> ciptestingboardatdeskdingledevdeployment#b-d-deployment-meth
> od-2-building-vm-
> from-scratch-using-vagrant-15
> <https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptestingboardatdeskdingledevdeployment#b-d-deployment-method-2-building-vm-from-scratch-using-vagrant-15>
>
> Any additional feedback from participants on this list is welcome.
>
> Best Regards
> --
> Agust?n Benito Bethencourt
> Principal Consultant
> Codethink Ltd
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20180313/1d531969/attachment-0001.html>
