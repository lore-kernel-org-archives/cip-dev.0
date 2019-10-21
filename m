From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 21 Oct 2019 12:10:44 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 06/57] ASoC: rsnd: ssi: Check
 runtime channel number rather than hw_params
In-Reply-To: <20191020091250.GA8003@amd>
References: <1571295929-47286-1-git-send-email-biju.das@bp.renesas.com>
	<1571295929-47286-7-git-send-email-biju.das@bp.renesas.com>
	<20191020091250.GA8003@amd>
Message-ID: <OSBPR01MB21036B6654B18BF32DC3707EB8690@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> Subject: Re: [PATCH 4.19.y-cip 06/57] ASoC: rsnd: ssi: Check runtime channel
> number rather than hw_params
> 
> Hi!
> 
> > commit 599da084e041b877ef89211dcbb4c7bd8380049d upstream.
> >
> > The number of channel handled by SSI maybe differs from the one set in
> > hw_params, currently SSI checks hw_params's channel number, and
> > constrains to use same channel number, when it is being used by
> > multiple clients.
> >
> > This patch corrects to check runtime channel number rather than
> > channel number set in hw_params.
> 
> This also changes the error return here from -EIO to -EINVAL. I assume that's
> okay, but I wanted to double check.
> 

Do you prefer -EIO rather than -EINVAL?  For me, -EINVAL make sense here.

Cheers,
Biju

> > +		if (ssi->chan != chan) {
> > +			dev_err(dev, "SSI parent/child should use same
> chan\n");
> > +			return -EINVAL;
> > +		}
> > +
> >  		return 0;
> >  	}
> >
> > @@ -519,24 +524,6 @@ static int rsnd_ssi_hw_params(struct rsnd_mod
> *mod,
> > -	if (ssi->usrcnt) {
> > -		/*
> > -		 * Already working.
> > -		 * It will happen if SSI has parent/child connection.
> > -		 * it is error if child <-> parent SSI uses
> > -		 * different channels.
> > -		 */
> > -		if (ssi->chan != chan)
> > -			return -EIO;
> > -	}
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
