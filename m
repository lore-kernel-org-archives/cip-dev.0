From: tuyen.hoangvan@toshiba-tsdv.com (tuyen.hoangvan at toshiba-tsdv.com)
Date: Mon, 17 Apr 2017 11:28:57 +0700
Subject: [cip-dev] CIP TSC meeting minutes (3 April 2017)
In-Reply-To: <390B4EACA1A32748BA6BC7F859F7D71655306C33@GSjpTKYDCembx31.service.hitachi.net>
References: <950bbc30-3c43-9b30-9b27-c27cf4e3c773@toshiba.co.jp>
	<390B4EACA1A32748BA6BC7F859F7D71655306C33@GSjpTKYDCembx31.service.hitachi.net>
Message-ID: <658751a8367d911161b2437fd71ddd02.squirrel@mail.toshiba-tsdv.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Dear Takuo Koguchi,

Thank you so much for your guide about building kernel for BBB.

I created a patch file to build minimal OS for BBB by using boot-loader
(u-boot) and

kernel (linux-base) based on meta-debian.

I would like to share you the patch at the attachment.

The patch is created for project-x, master branch.

Best regards,

Tuyen

> Hi Yoshi,
>
> Regarding to my project-x action item, recipes-kernel for BBB and CycloneV
> is already posted.
>
> If you copy recipes-kernel to your usual poky build (i.e. DISTRO = poky
> without meta-debian,)
> you will be able to bitbake virtual/kernel.
>
> But it you want to use this recipe with meta-debian, there are some
> issues.
> 1) you have to add meta-PROJECTX/conf/local.conf.sample and
> bblayer.conf.sample manually.
>  This is my fault. I forgot to include these files. You can copy these
> files from deby-qemux86-64/meta-PROJECTX/conf
>
> If you do the above, you can bitbake virtual/kernel if the followings are
> in conf/local.conf
> MACHINE="beaglebone"
> LINUX_DEFCONFIG="omap2plus_defconfig"
>
> But this is still not what I meant for.
> In the above mentioned build my "linux-cip" recipe is not used even if
> PREFERRED_PROVIDER_virtual/kernel = "linux-cip"
> is defined in local.conf because PREFERRED_PROVIDER _virtual/kernel is
> overwritten
> by meta-debian/conf\/distro/include/debian-preferred-provider.inc:2
> to     "linux-base"
>
> I hope you can change
> PREFERRED_PROVIDER_virtual/kernel = "linux-base"
> for
> PREFERRED_PROVIDER_virtual/kernel ?= "linux-base"
>
> Unfortunately there are still some issue to build kernel with meta-debian.
> I am working on it.
>
>
> Best Regard,
>
> Takuo Koguchi
>
>> -----Original Message-----
>> From: cip-dev-bounces at lists.cip-project.org
>> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of KOBAYASHI
>> Yoshitake
>> Sent: Thursday, April 06, 2017 2:07 PM
>> To: cip-dev at lists.cip-project.org
>> Subject: [!][cip-dev] CIP TSC meeting minutes (3 April 2017)
>>
>> Hi everyone,
>>
>> I uploaded the meeting minutes for CIP Technical Steering Committee
>> meeting held 3
>> April, 2017 at the following link.
>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/tsc-meetings/tsc_mm_apr03201
>> 7
>>
>> Past TSC meeting minutes can be find at the following link.
>> https://wiki.linuxfoundation.org/civilinfrastructureplatform/tsc-meetings.
>>
>> Best regards,
>> Yoshi
>>
>>
>> _______________________________________________
>> cip-dev mailing list
>> cip-dev at lists.cip-project.org
>> https://lists.cip-project.org/mailman/listinfo/cip-dev
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
> --
> This mail was scanned by BitDefender
> For more information please visit http://www.bitdefender.com
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-deby-armv7-Add-deby-armv7-to-build-a-minimal-OS-for-.patch
Type: application/octet-stream
Size: 10807 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170417/ed9732b0/attachment.obj>
-------------- next part --------------
-- 
This mail was scanned by BitDefender
For more information please visit http://www.bitdefender.com
