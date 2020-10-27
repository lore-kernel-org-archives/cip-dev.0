Return-Path: <SRS0=3ZcY=EC=lists.cip-project.org=bounce+64572+5683+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D67C4363A
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 22:16:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D019321D24
	for <cip-dev@archiver.kernel.org>; Tue, 27 Oct 2020 22:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Fpol6ZBd"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5683+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id tan9YY4521723xxZgTn1faiB; Tue, 27 Oct 2020 15:16:40 -0700
X-Received: from imap3.hz.codethink.co.uk (imap3.hz.codethink.co.uk [176.9.8.87])
 by mx.groups.io with SMTP id smtpd.web09.4755.1603836999201947670
 for <cip-dev@lists.cip-project.org>;
 Tue, 27 Oct 2020 15:16:39 -0700
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap3.hz.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kXXGe-00031N-0C
	for <cip-dev@lists.cip-project.org> ; Tue, 27 Oct 2020 22:16:36 +0000
Message-ID: <35ba5a3c63dd41c15f1cf63e99ba01e99316bce4.camel@codethink.co.uk>
Subject: [cip-dev] Leaving Codethink and CIP
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Date: Tue, 27 Oct 2020 22:16:34 +0000
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: GYnhq9bf1OEltNq6aKoUVPDvx4520388AA=
Content-Type: multipart/mixed; boundary="WnKFnKXZIbwD6CPSYMSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1603837000;
 bh=ZfxmjEx8T8NzlSERwinbFt2oNYyYQAHRSvqQ04MQhQc=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Fpol6ZBdlb6RZ++DspDzyxTvetNht/BCzmLkIlL1YsYPad3ILuO0gYX2L8VZfmaozNe
 ag36xYwRVXXxE0kUQBAtWSSYlUJmqUueCxmNbzOBQ9Q9ish2CQrWlN7lfhtM3eJm2lcAt
 cj5ftsayVK6x1wYMjWRP18jLf5Sj1Bs5DmI=

--WnKFnKXZIbwD6CPSYMSh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

I will be leaving Codethink next month, and will no longer be working
directly on CIP.  (With my Debian hat on, I may still submit merge
requests to the cip-kernel-sec repository.)  My last working day here
will be 11 November.

I want to thank everyone who's worked to make super-long-term Linux
kernel maintenance possible.  CIP has a great kernel team now and I'm
confident that you'll carry on doing a fine job without me.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--WnKFnKXZIbwD6CPSYMSh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5683): https://lists.cip-project.org/g/cip-dev/message=
/5683
Mute This Topic: https://lists.cip-project.org/mt/77850039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--WnKFnKXZIbwD6CPSYMSh--
