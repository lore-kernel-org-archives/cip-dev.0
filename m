Return-Path: <SRS0=1lzB=ER=lists.cip-project.org=bounce+64572+5791+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54232C388F9
	for <cip-dev@archiver.kernel.org>; Wed, 11 Nov 2020 20:50:15 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4034B20797
	for <cip-dev@archiver.kernel.org>; Wed, 11 Nov 2020 20:50:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="lGQOU+Ps"
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5791+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id YKFzYY4521723xLXmaUwXHJr; Wed, 11 Nov 2020 12:50:13 -0800
X-Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
 by mx.groups.io with SMTP id smtpd.web09.13165.1605127812642920338
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2020 12:50:13 -0800
X-Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=xylophone)
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kcx47-0004f5-HS; Wed, 11 Nov 2020 20:50:03 +0000
Message-ID: <9c52fda6f710d3aad6fd9f781b33c4034dee4d10.camel@codethink.co.uk>
Subject: Re: [cip-dev] Backporting of security patches for Intel i40e drivers required?
From: "Ben Hutchings" <ben.hutchings@codethink.co.uk>
To: cip-dev@lists.cip-project.org, nobuhiro1.iwamatsu@toshiba.co.jp, 
	jan.kiszka@siemens.com
Date: Wed, 11 Nov 2020 20:50:02 +0000
In-Reply-To: <TY2PR01MB4972EDB29B2AB0B3AE5E363DA0E80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
References: 
	<TY2PR01MB49721EDA34600391409FFB07A00B0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
	 <OSBPR01MB298313D24CA5EF5B0517AB4792080@OSBPR01MB2983.jpnprd01.prod.outlook.com>
	 <d5baee23-9a71-6994-146d-1b54d42d1ef9@siemens.com>
	 <TY2PR01MB4972EDB29B2AB0B3AE5E363DA0E80@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Organization: Codethink Ltd.
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: fOZjEyLQ8iWkZgTrGE2PwDtDx4520388AA=
Content-Type: multipart/mixed; boundary="QEgsiipmuYsSJWtkcDJW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1605127813;
 bh=LQsqBevRuuML9uaCXCP2WkUxT7c4gbjIWvjQPLQvID0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=lGQOU+PsIq9JWW4CWOXoHUkMmT9DpNGu929X5roxW1cYX86jZg+sPEipIUPz0jqeAFK
 JHJ+rTP3gdjT0VcgZhiNiJX6s6ZhpBXdmBa7WYM6gCCDRx5g7TeajPLO2R5zzlQnFkD1q
 djUCoZTkwyf3xIp9KHov4s/c1fH7x1N31lk=

--QEgsiipmuYsSJWtkcDJW
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2020-11-11 at 13:18 +0000, masashi.kudo@cybertrust.co.jp wrote:
> Hi, 
> 
> The other day, I inquired about CVE-2019-0145, CVE-2019-0147, and CVE-2019-0148 in the following email.
> 
> The kernel team discussed for weeks how to deal with them.
> As a result of these discussions, we concluded to ignore them until Intel fixes issues, because:
>  - The descriptions of patches are not clear, and we cannot figure out what is right
>  - The patches we identified do not really look like fixing too serious stuff.

They all seemed to involve communication with the owner of a PCIe
Virtual Function (VF).  A VF might be assigned to a VM or privileged
process.  In Civil Infrastructure systems those should already be
trusted and so the issues don't matter that much.

> So far, we had the following AI, but we close this based on the above situation.
> 
> 2. Check whether CVE-2019-0145, CVE-2019-0147, CVE-2019-0148 needs to be backported to 4.4 - Kernel Team
[...]

Well, I found it quite easy to backport the applicable parts of the
fixes.  I already sent them along with some other fixes for the 4.14
and 4.9 branches, and could still do so for 4.4.

Ben.

-- 
Ben Hutchings, Software Developer                         Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom


--QEgsiipmuYsSJWtkcDJW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5791): https://lists.cip-project.org/g/cip-dev/message=
/5791
Mute This Topic: https://lists.cip-project.org/mt/77380165/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--QEgsiipmuYsSJWtkcDJW--
