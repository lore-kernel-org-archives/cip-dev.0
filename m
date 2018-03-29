From: zoran.stojsavljevic.de@gmail.com (Zoran S)
Date: Thu, 29 Mar 2018 10:23:58 +0200
Subject: [cip-dev] B@D: iwg20m support
In-Reply-To: <7ed4ea7d408442269e0ab4206e2ea9e6@rvc.renesas.com>
References: <1513231035-42479-1-git-send-email-daniel.sangorrin@toshiba.co.jp>
	<8334d32c-edfb-76dd-3246-dca7cd9a9d62@siemens.com>
	<006d01d3786a$533dec70$f9b9c550$@toshiba.co.jp>
	<69bab283668346d480ae1f5957b054fb@rvc.renesas.com>
	<018401d38925$8188fc70$849af550$@toshiba.co.jp>
	<0f469353c2f94f64a2a55a3eb3f02317@rvc.renesas.com>
	<001801d389a5$45b84630$d128d290$@toshiba.co.jp>
	<e50cd71ea4d444889b39b3a96876a59f@rvc.renesas.com>
	<000f01d389d3$715dbdf0$541939d0$@toshiba.co.jp>
	<bacb02dc0d194be8b13138e98cf8aa33@rvc.renesas.com>
	<008f01d38a9f$fdce8680$f96b9380$@toshiba.co.jp>
	<8681e318c0eb4598af7883c30aea66be@rvc.renesas.com>
	<71f8826a9cbe47599f4e3e45b3dc8209@rvc.renesas.com>
	<006601d3c49e$eca85cd0$c5f91670$@toshiba.co.jp>
	<CAEss1E+RhozLMoMKrKz1P4gUgtM_mSdCuS7y37GDh=pts2Urzw@mail.gmail.com>
	<fb8c257078ca461caafeb60c7dd5cf3c@rvc.renesas.com>
	<00ac01d3c4de$c0237790$406a66b0$@toshiba.co.jp>
	<9151f4fcd8244ed9985ea3c81ce44e34@rvc.renesas.com>
	<00ae01d3c4e0$b48d8bd0$1da8a370$@toshiba.co.jp>
	<6afbe7517b484b508ce366d33c2e9c12@rvc.renesas.com>
	<CAEss1EJRp0ehW4fmPQZV7z=s+RyjOSTpJyDFD_oB7tCZA69qsg@mail.gmail.com>
	<7ed4ea7d408442269e0ab4206e2ea9e6@rvc.renesas.com>
Message-ID: <CAEss1EKqbG_EwEPfp+1CZeF7RV2cfOyHUiguqoXKzoUV6+hV-w@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Tram,

I just checked the dtb/ with v4.4.120-cip20-rt13, and there, these are
the exact same files.

Since I am not at all able to make working example out of YOCTO (I do
not have SDK). I use:
https://elinux.org/RZ-G/Boards/Yocto_2.0

I even followed what you all did:
TUNE_FEATURES     = "arm armv7a vfp neon callconvention-hard cortexa15hf"

I have the very last ask: when you bring up the iwg20m SDK image from
U-boot to the Linux kernel, what will be the root prompt (so I can
exercise some more Lava iwg20m use cases)?

Should be: [root at iwg20m]#, but this does not play well with Lava (it
reports to me: invalid prompt)?!

Thank you,
Zoran
_______

On Thu, Mar 29, 2018 at 5:37 AM, Tram Quynh Thi. Nguyen
<tram.nguyen.xw@rvc.renesas.com> wrote:
> Hello Zoran,
>
> Yes. Please refer attached files for your information.
>
> Best regards,
> Tram Nguyen
>
> -----Original Message-----
> From: Zoran S [mailto:zoran.stojsavljevic.de at gmail.com]
> Sent: Wednesday, March 28, 2018 6:52 PM
> To: Tram Quynh Thi. Nguyen <tram.nguyen.xw@rvc.renesas.com>
> Cc: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>; O365-Anh The. Tran <anh.tran.jc@renesas.com>; O365-Yasushi Onishi <yasushi.onishi.xc@renesas.com>; O365-Yoshinori Kaneko <yoshinori.kaneko.xg@renesas.com>; cip-dev at lists.cip-project.org; Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>; O365-Minh Thuy Dinh. Tran <minh.tran.xc@renesas.com>; O365-Chan Duc. Vu <chan.vu.xv@renesas.com>
> Subject: Re: [cip-dev] B at D: iwg20m support
>
> Hello Tram,
>
> Could you, please, do me a favour?
>
> Could you, please, find for me the kernel tree after you did build your kas SDK (supposed to be 4.4.-x) tree, and from there to retrieve for me the following .dts files:
>
> path: kernel-top-dir/arch/arm/boot/dts, the files:
>
> r8a7743.dtsi
> r8a7743-iwg20d-q7.dts
> r8a7743-iwg20m.dtsi
>
> And, please, attach them for me to the email for inspection?
>
> Thank you,
> Zoran
> _______
