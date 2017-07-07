From: Chris.Paterson2@renesas.com (Chris Paterson)
Date: Fri, 7 Jul 2017 13:20:25 +0000
Subject: [cip-dev] Renesas dev CIP repository announcement
In-Reply-To: <b33ff48c-eb23-2fa8-0fc8-f062a95e1444@toshiba.co.jp>
References: <TY1PR06MB0702667AD2F56BEBDFFCF9A1B7C50@TY1PR06MB0702.apcprd06.prod.outlook.com>
	<b33ff48c-eb23-2fa8-0fc8-f062a95e1444@toshiba.co.jp>
Message-ID: <TY1PR06MB070290B803A18D2EE9C54A6BB7AA0@TY1PR06MB0702.apcprd06.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Yoshi-san,

> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
> bounces at lists.cip-project.org] On Behalf Of KOBAYASHI Yoshitake
> Sent: 07 July 2017 14:07
> 
> Hi Chris and all,
> 
> > [1] https://github.com/renesas-rz/renesas-cip
> 
> I had looked the repository and have a suggestion.
> When you backport patches from upstream, could you add the following line
> in commit message?
> 
>   (cherry picked from commit UPSTREAM_COMMIT_ID)
> 
> I think this approach might be better for the tracablity reason. But this is just
> a suggestion and I would like to know others opinion.

Agreed. We intend to follow the proper process when backporting to the actual CIP Kernel.

The repository above is just a quick release to allow users to get the iWave RZ/G1M board up and running for now. Most of the patches haven't come from upstream as there is no upstream support for the iWave RZ/G1M board yet (in progress).

Kind regards, Chris


> 
> Best regards,
> Yoshi
> 
> On 2017/06/20 17:49, Chris Paterson wrote:
> > Dear CIP friends,
> >
> >
> >
> > I'd like to announce the availability of a development repo [1] based on the
> CIP Kernel for the iWave RZ/G1M Qseven Development Platform [2].
> >
> >
> >
> > The main aim of this repository is to allow CIP users to get up and running
> with the Renesas CIP reference platform. Please note that this is just an
> interim step as support for the platform is added upstream/backported to
> the CIP Kernel.
> >
> >
> >
> > Currently there are two branches, one based on v4.4.55-cip3, and the other
> based on v4.4.69-cip4.
> >
> >
> >
> > Please use the "shmobile_defconfig" configuration when compiling, and
> use r8a7743-iwg20m.dtb. uImage LOADADDR should be set to "0x40008000".
> For u-boot environment settings, please see the iWave documentation that
> should come with the boards.
> >
> >
> >
> >
> >
> > [1] https://github.com/renesas-rz/renesas-cip
> >
> > [2] http://www.iwavesystems.com/rz-g1m-qseven-development-kit.html
> >
> >
> >
> > Kind regards, Chris
> >
> >
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
