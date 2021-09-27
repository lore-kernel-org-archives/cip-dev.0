Return-Path: <SRS0=iFFi=OR=lists.cip-project.org=bounce+64572+6753+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBEC433F5
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 10:44:06 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A1B61056
	for <cip-dev@archiver.kernel.org>; Mon, 27 Sep 2021 10:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50A1B61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fpond.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id gMFbYY4521723xU2BhcagSrd; Mon, 27 Sep 2021 03:44:05 -0700
X-Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
 by mx.groups.io with SMTP id smtpd.web08.29636.1632739434435040140
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Sep 2021 03:44:04 -0700
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvv3qxio1R8fGl/w2B+Io="
X-RZG-CLASS-ID: mo00
X-Received: from oxapp02-03.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.33.8 AUTH)
    with ESMTPSA id c00f85x8RAhpYWo
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Mon, 27 Sep 2021 12:43:51 +0200 (CEST)
Date: Mon, 27 Sep 2021 12:43:51 +0200 (CEST)
From: "Ulrich Hecht" <uli@fpond.eu>
To: cip-dev@lists.cip-project.org, Pavel Machek <pavel@denx.de>
Message-ID: <1532955493.576116.1632739431463@webmail.strato.com>
In-Reply-To: <20210927100950.GA11971@amd>
References: <20210927100950.GA11971@amd>
Subject: Re: [cip-dev] Coordinating stable reviews
MIME-Version: 1.0
X-Priority: 3
Importance: Normal
X-Originating-Client: open-xchange-appsuite
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Urn8ujtsG8I6W1iQ0CyhIa7Ux4520388AA=
Content-Type: multipart/mixed; boundary="BtLn6VWAV6q51VRRXv8u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632739445;
 bh=X54prI8V2w6KtED3kfW+vinNFwqN4fz6cvV6dCn3VRY=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IWEzXG4f+CnJK43+Jjod8MHni2WSXZYMjbans0BY/DLHAKEvnthYphE2avkXxBvqCER
 wKBeaxl1j513SxRzBdlilwDsPA0ZcmHDN0bQVf3yKKyto36HOINcMGrRYPzgxsbtNk4au
 cZSfvNIk+9VYvikc4nfn3nUxHnrr5O1okpw=
Message-ID: <20210927104351.-Ksk2jsVtXNNzYAFs7as0v1o8cPOJkD6B45oQ1Ou9p4@z>

--BtLn6VWAV6q51VRRXv8u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


> On 09/27/2021 12:09 PM Pavel Machek <pavel@denx.de> wrote:
> Unfortunately, we don't have good system for coordinating reviews in
> -rc phase.
> 
> There's a script (commit.py) that produces one-line-per-patch output
> suitable for review. One possibility would be to have shared place
> somewhere reviewers could tag "I'm working on these patches".
> 
> I don't believe lts-commit-list.git repository is suitable for that;
> format suitable for review is different from what we have in
> lts-commit-list, and there is going to be multiple updates per day in
> busy periods.
> 
> We don't really need commit messages for this. Actually, we don't
> really need to keep history, either. It would be good if system could
> be controlled from command line for easy scripting.
> 
> Any ideas what kind of service could be used for this?

gitlab comes to mind. IIUC, wiki pages are part of the project, but
contained in a separate git repository.

The output of commit.py is practically markdown already; just add a
table header and some extra "|"'s, and you're good.

There will be a history, but I think that can be safely ignored.

CU
Uli

--BtLn6VWAV6q51VRRXv8u
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6753): https://lists.cip-project.org/g/cip-dev/message/=
6753
Mute This Topic: https://lists.cip-project.org/mt/85896746/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--BtLn6VWAV6q51VRRXv8u--
