Return-Path: <SRS0=twS7=EW=lists.cip-project.org=bounce+64572+5802+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF5CC4742C
	for <cip-dev@archiver.kernel.org>; Mon, 16 Nov 2020 13:57:28 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 039DE22245
	for <cip-dev@archiver.kernel.org>; Mon, 16 Nov 2020 13:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="p3g+Yjy3"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5802+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NZr0YY4521723xwrQCcULa0E; Mon, 16 Nov 2020 05:57:27 -0800
X-Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by mx.groups.io with SMTP id smtpd.web12.34744.1605535046198386675
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Nov 2020 05:57:26 -0800
X-Received: from host-92-5-241-147.as43234.net ([92.5.241.147] helo=[192.168.1.13])
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kef0V-0003fk-Ki
	for <cip-dev@lists.cip-project.org> ; Mon, 16 Nov 2020 13:57:23 +0000
To: cip-dev@lists.cip-project.org
From: "Sudip Mukherjee" <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] Joining CIP from Codethink
Message-ID: <9bd054d9-3b0e-d339-2d3f-7471ebc5421d@codethink.co.uk>
Date: Mon, 16 Nov 2020 13:57:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: RV3SpsrifTVnJX71vIypsonLx4520388AA=
Content-Type: multipart/mixed; boundary="5EeUEnJm7l4zMGf2hQjb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605535047;
 bh=Yq+w1KK2nDrXEil4r1a1UisUblpGMavuu48VGVC6stE=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=p3g+Yjy3oajsdDJv7qj4WnBRFRpJUc4cuvJ/6SHrGt5uboOWOLuekKHlGZWRS86Yq0D
 BtvPKJv3W23JtRRB4IOCAuzMJKRbbZvXBJ4oHFAQBm3rI1b5u/EOFD2IYPkw6b09t6efW
 afcoPotpxsgzMt2nWMo4Yy6DfdSRi9ZQPZA=

--5EeUEnJm7l4zMGf2hQjb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi All,

I am starting with CIP and will be trying to do what Ben used to do.
Though many of my colleagues and ex-colleagues have worked with CIP,
this will be my first time directly working with CIP and excited with
the chance to contribute to the super-long-term Linux Kernel.



-- 
Regards
Sudip

--5EeUEnJm7l4zMGf2hQjb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5802): https://lists.cip-project.org/g/cip-dev/message=
/5802
Mute This Topic: https://lists.cip-project.org/mt/78291887/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5EeUEnJm7l4zMGf2hQjb--
