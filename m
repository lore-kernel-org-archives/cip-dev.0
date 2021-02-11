Return-Path: <SRS0=taqo=HN=lists.cip-project.org=bounce+64572+6172+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070EFC433DB
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 23:04:27 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D49D064DD5
	for <cip-dev@archiver.kernel.org>; Thu, 11 Feb 2021 23:04:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D49D064DD5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6172+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id abfVYY4521723xstYARLMNRZ; Thu, 11 Feb 2021 15:04:25 -0800
X-Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
 by mx.groups.io with SMTP id smtpd.web08.4424.1613084664414949108
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Feb 2021 15:04:24 -0800
X-Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
	id 2D4FF1C0B8F; Fri, 12 Feb 2021 00:04:20 +0100 (CET)
Date: Fri, 12 Feb 2021 00:04:19 +0100
From: "Pavel Machek" <pavel@denx.de>
To: Chris.Paterson2@renesas.com, cip-dev@lists.cip-project.org
Subject: [cip-dev] 5.10.16 testing failing
Message-ID: <20210211230418.GA14799@amd>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 90NxoxPxUh7SWuy5LGVZBcawx4520388AA=
Content-Type: multipart/mixed; boundary="CTDLCS9NWFLMPXf9jTF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1613084665;
 bh=zjwyE9cDee10rVlzCF3aBVtSMHbsbQfWhXMO7IbpHtE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=rxajns3rWPm/Ui+4LOnygPaCP+Zu/tXoM8tIvpMSTbeu3rYtnHw4h3zin2BqaLRFBNs
 bv89ZHNlFMchN+h/GndX0esoOY8hYo2+wOZnUl/i2Jjxz4PXJvRTL+X4z8R+VrS9PDgvo
 o+lNIUoA6dD3eZYXzJ326BH3c4VSMInOOS0=

--CTDLCS9NWFLMPXf9jTF1
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

Latest -stable-rc tests are failing, both for 4.19 and for 5.10.16. I
resubmitted tests and some succeeded on second try, but most did not.

It does not seem to be real failures, it seems more like network problems.

https://gitlab.com/cip-project/cip-testing/linux-stable-rc-ci/-/pipelines/2=
54936494
https://lava.ciplatform.org/scheduler/job/162225
extra keys not allowed @
data['actions[2]']['test']['definition']['definitions'][0]['repository']['m=
etadata']['version']
progress  65% (59MB)
http-download timed out after 895 seconds
end: 1.3.1 http-download (duration 00:14:55) [common]
tftp-deploy timed out after 1715 seconds
end: 1.3 download-retry (duration 00:13:35) [common]

https://lava.ciplatform.org/scheduler/job/162215
(does not load logs at all?)

etc...

Best regards,
       		  	    	     	      	       	   Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmAlt/IACgkQMOfwapXb+vKdFACgnhm9rKBMMyTOs1TzVPfJu3Tt
LTUAoIfAsUUEteHhgxaoz6lCzglfqS5i
=ocFO
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--

--CTDLCS9NWFLMPXf9jTF1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6172): https://lists.cip-project.org/g/cip-dev/message=
/6172
Mute This Topic: https://lists.cip-project.org/mt/80571344/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--CTDLCS9NWFLMPXf9jTF1--
