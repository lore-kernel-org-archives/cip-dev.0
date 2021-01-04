Return-Path: <SRS0=Vupx=GH=lists.cip-project.org=bounce+64572+5996+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE589C433DB
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 14:10:37 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCEAB20770
	for <cip-dev@archiver.kernel.org>; Mon,  4 Jan 2021 14:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org; dmarc=permerror header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5996+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yrAEYY4521723xhrS4ZzjjZR; Mon, 04 Jan 2021 06:10:36 -0800
X-Received: from imap2.colo.codethink.co.uk (imap2.colo.codethink.co.uk [78.40.148.184])
 by mx.groups.io with SMTP id smtpd.web12.14073.1609769435247280063
 for <cip-dev@lists.cip-project.org>;
 Mon, 04 Jan 2021 06:10:35 -0800
X-Received: from aelfric.plus.com ([80.229.143.166] helo=[172.20.10.33])
	by imap2.colo.codethink.co.uk with esmtpsa  (Exim 4.92 #3 (Debian))
	id 1kwQZ5-0006NW-EM
	for <cip-dev@lists.cip-project.org> ; Mon, 04 Jan 2021 14:10:31 +0000
To: cip-dev@lists.cip-project.org
From: "Jonathan Sambrook" <jonathan.sambrook@codethink.co.uk>
Subject: [cip-dev] GitLab Merge Requests not working
Organization: Codethink.co.uk
Message-ID: <0282a51a-682c-bb5e-4a68-e020ac0e76d5@codethink.co.uk>
Date: Mon, 4 Jan 2021 14:10:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: k47utNi27mqqvbyrIUtiDx6nx4520388AA=
Content-Type: multipart/mixed; boundary="XJLwCSd1BeKK0c5iiXHy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1609769436;
 bh=4Eb0jUfbJzlbn573zmElgK0dF2RicjOTCf3HFHYynqw=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=op3jUD5/e7EAHaDXyPznfkwiSjpglBKspuIhAe2RKZ7Kruvpu4bUcvpk0OSaJtH6Kqf
 NTLzitNQUdAcsKdEncOqQ70EMZ8v1e9KlfwZqb9RSzRf/xb9GYKIqvodPWN+4L0b2un95
 bJUTjqGOVUbLkgc7MwBMJBdN+60chIwcHUI=

--XJLwCSd1BeKK0c5iiXHy
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

Hi,

When I try to submit a MR on
https://gitlab.com/cip-project/cip-kernel/cip-kernel-sec, I get:

  500

  Whoops, something went wrong on our end.
	
  Try refreshing the page, or going back and attempting the action again.

  Please contact your GitLab administrator if this problem persists.

This is not a transient issue - I previously tried on 24/12/2020.

I've tried logging out and back in, and logging in afresh in a different browser.

tpollard, patersonc, and wens have each confirmed this as a problem.

  10:33:29 <tpollard> I cannot submit an MR either
  10:33:43 <tpollard> (simple README change from the web gui)

  10:36:58 <patersonc> Hi ebardie, I just tried to create an MR using your
branch and also see the 500 issue. I've got god rights on the CIP project so I
guess it must be a GitLab issue rather then a permissions thing

Email from wens:

> Doesn't work for me either.
> Could you send a public email to the cip-dev mailing list to raise the issue?

Who should I contact regarding this?

Kind regards,
Jonathan

-- 
Jonathan Sambrook, Software Engineer        http://www.codethink.co.uk/
  Codethink Ltd., Third Floor, Dale House, 35 Dale Street, Manchester
   M1 2HF, United Kingdom   https://www.codethink.co.uk/privacy.html

--XJLwCSd1BeKK0c5iiXHy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5996): https://lists.cip-project.org/g/cip-dev/message=
/5996
Mute This Topic: https://lists.cip-project.org/mt/79424151/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--XJLwCSd1BeKK0c5iiXHy--
