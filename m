From: pavel@denx.de (Pavel Machek)
Date: Wed, 4 Dec 2019 13:36:51 +0100
Subject: [cip-dev] [PATCH 4.4.y-cip] gpiolib: Fix invalid access of
	nullptr
In-Reply-To: <OSAPR01MB323449CF4631A8179A0EC6BE925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <14717888-518c-3643-b98e-4a052c14c102@siemens.com>
 <TY1PR01MB177064C0DFD2CCE7D43B3BE4C0430@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <OSAPR01MB323449CF4631A8179A0EC6BE925D0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <20191204123651.GA29179@duo.ucw.cz>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> > That's a known problem, please have a  look at:
> > https://patchwork.kernel.org/patch/11235267/
> > 
> > Pavel, Iwamatsu-san, could you please take patch:
> > https://patchwork.kernel.org/patch/11235267/
> > 
> > I think this is quite urgent as others will stumble across the problem
> > and will try and fix it.
> 
> OK, I will apply this with following comment if there is no other opinion.
> 
> NOTE: gpiochip_add_data()'s fixes is based on 6ff0497402ef7269ee6a72f62eb85adaa7a4768e.

Sounds good to me.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 195 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20191204/16963314/attachment.sig>
