From: akihiro27.suzuki@toshiba.co.jp (akihiro27.suzuki at toshiba.co.jp)
Date: Mon, 18 Mar 2019 05:55:05 +0000
Subject: [cip-dev] [PATCH] Add a console option to the kernel command
	line
In-Reply-To: <a724b46c-3c8f-fe67-546a-d036dac80c7d@siemens.com>
References: <20190315063834.3788-1-akihiro27.suzuki@toshiba.co.jp>
	<20190315063834.3788-2-akihiro27.suzuki@toshiba.co.jp>
	<a724b46c-3c8f-fe67-546a-d036dac80c7d@siemens.com>
Message-ID: <TY2PR01MB51468E02C4A674214EB1768BD9470@TY2PR01MB5146.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Jan,

I agree with your opinion.
We have to be able to use a uart console even if DISPLAY has a value.

But I couldn't understand the statement of "That's how it is on ARM[64] already".
Could you explain it in more detail?
Do you mean that, on ARM[64], we don't have to add console option to KERNEL_CMDLINE
on current start-qemu.sh?

Best regards,
Suzuki


> -----Original Message-----
> From: Jan Kiszka [mailto:jan.kiszka at siemens.com]
> Sent: Friday, March 15, 2019 6:17 PM
> To: suzuki akihiro(?? ?? ????????)
> <akihiro27.suzuki@toshiba.co.jp>; cip-dev at lists.cip-project.org
> Subject: Re: [cip-dev] [PATCH] Add a console option to the kernel command
> line
> 
> On 15.03.19 07:38, Akihiro Suzuki wrote:
> > This option is required when starting qemu-amd64 with nographic.
> >
> > Signed-off-by: Akihiro Suzuki <akihiro27.suzuki@toshiba.co.jp>
> > ---
> >   start-qemu.sh | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/start-qemu.sh b/start-qemu.sh
> > index b71ba32..52498fa 100755
> > --- a/start-qemu.sh
> > +++ b/start-qemu.sh
> > @@ -79,6 +79,7 @@ INITRD_FILE=$(ls ${IMAGE_PREFIX}.initrd.img* | tail
> -1)
> >
> >   if [ -z "${DISPLAY}" ]; then
> >   	QEMU_EXTRA_ARGS="${QEMU_EXTRA_ARGS} -nographic"
> > +	KERNEL_CMDLINE="${KERNEL_CMDLINE} console=ttyS0"
> >   fi
> >
> >   shift 1
> >
> 
> Valid point. But I think this should rather go to the original, per-target
> definition of KERNEL_CMDLINE. And we can make it unconditional, ie.
> provide a
> uart console independent of DISPLAY settings. That's how it is on ARM[64]
> already.
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
