From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 8 Nov 2019 13:20:13 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 41/83] mmc: tmio: Add tuning support
In-Reply-To: <20191108093637.GJ1017@amd>
References: <1573115572-13513-1-git-send-email-biju.das@bp.renesas.com>
	<1573115572-13513-42-git-send-email-biju.das@bp.renesas.com>
	<20191108093637.GJ1017@amd>
Message-ID: <OSBPR01MB2103A157456F537A791DEDF5B87B0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> Subject: Re: [PATCH 4.4.y-cip 41/83] mmc: tmio: Add tuning support
> 
> Hi!
> 
> > commit 4f11997773b6b452b5a0d620c5ac5050e75c227e upstream.
> >
> > Add tuning support for use with SDR104 mode
> >
> 
> > +	/* Tuning values: 1 for success, 0 for failure */
> > +	DECLARE_BITMAP(taps, BITS_PER_BYTE * sizeof(long));
> 
> I don't see why tuning should depend on register size (thus
> sizeof(long)) of the host CPU. If 32 is enough, put 32 there... if not, just use
> 64?
> 
> > +	if (host->tap_num * 2 >= sizeof(host->taps) * BITS_PER_BYTE) {
> > +		dev_warn_once(&host->pdev->dev,
> > +		      "Too many taps, skipping tuning. Please consider updating
> size of taps field of tmio_mmc_host\n");
> > +		goto out;
> > +	}
> 
> Or perhaps introduce a #define MAX_TAPS; it will be cleaner than checking
> bit sizes like this.
> 
Yes there is a room for improvement for this patch in Mainline.

Regards,
Biju
