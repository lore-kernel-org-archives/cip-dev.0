From: pavel@denx.de (Pavel Machek)
Date: Thu, 29 Aug 2019 10:12:21 +0200
Subject: [cip-dev] [PATCH/RFC 4.19.y-cip 00/41] Fast forward sh-pfc
In-Reply-To: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1566991328-25476-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <20190829081221.GD10041@amd>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi!

> they have made good progress upstream with the development of sh-pfc,
> and although the functionality of the drivers hasn't changed much,
> the code looks fairly different. This means that backporting patches
> to SoC specific driver files will be increasingly hard and error
> prone, unless we fast-forward the code base for 4.19.y-cip, hence
> this series.
> What do you gus think? Comments welcome!

I reviewed the patches... and it is interesting how much magic can be
done with preprocessor.

I do not see anything preventing the merge, but they were marked [rfc]
so I'm not doing that yet. Let me know if I should.

Best regards,
								Pavel
-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20190829/655ee367/attachment.sig>
