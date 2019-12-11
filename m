From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 11 Dec 2019 14:45:45 +0100
Subject: [cip-dev] Linux 4.19.89-rc1 5944fcdd errors
In-Reply-To: <TYAPR01MB22852454802BAB486871D944B75A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
References: <TYAPR01MB228505DBC22568339F914C15B7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191209173637.GF1290729@kroah.com>
 <TYAPR01MB2285135B15E6A152163E1A1AB7580@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191210073514.GB3077639@kroah.com>
 <TYAPR01MB2285B5834B1FBA71F8DA512BB75B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191210145528.GA4012363@kroah.com>
 <TYAPR01MB2285433EA1E6DF9EC621E31AB75B0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
 <20191210205951.GA4081499@kroah.com>
 <TYAPR01MB22852454802BAB486871D944B75A0@TYAPR01MB2285.jpnprd01.prod.outlook.com>
Message-ID: <20191211134545.GC523125@kroah.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, Dec 11, 2019 at 10:52:44AM +0000, Chris Paterson wrote:
> Hello Greg,
> 
> [...]
> 
> > > > That's a lot, are these all new?
> > >
> > > I've only just started building with this config in our CI setup, but
> > > building the dtbs locally with v4.19.88 didn't produce these results
> > > for me (and building locally with v4.19.89-rc1 does result in the
> > > above issues).
> > 
> > Any chance you can run 'git bisect' to track down the offending patch?
> 
> The two dtbs that fail to build are fixed by reverting by the patches below:
> 
> > allwinner/sun50i-a64-pinebook.dtb
> ea03518a3123 ("arm64: dts: allwinner: a64: enable sound on Pinebook")

Now dropped.

> > qcom/sdm845-mtp.dtb
> d0a925e2060d ("arm64: dts: qcom: sdm845-mtp: Mark protected gcc clocks")

Now dropped.

> The rest of the dtbs just had warnings, all produced by the patch below:
> 
> > arm/juno.dtb
> > qcom/apq8016-sbc.dtb
> > arm/juno-r2.dtb
> > arm/juno-r1.dtb
> > hisilicon/hi6220-hikey.dtb
> > qcom/msm8916-mtp.dtb
> > qcom/msm8916-mtp.dtb
> 3fa6a276a4bd ("kbuild: Enable dtc graph_port warning by default")

Now dropped as well.

I'll push out new kernels in a bit, thanks for this info.

greg k-h
