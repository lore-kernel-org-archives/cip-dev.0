Return-Path: <uli@fpond.eu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044F8E7716B
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 06:08:11 +0000 (UTC)
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.163])
 by mx.groups.io with SMTP id smtpd.web10.7772.1733292481620592428
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Dec 2024 22:08:02 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0002 header.b=ooJoXKX1;
 dkim=pass header.i=@fpond.eu header.s=strato-dkim-0003 header.b=faw1htT9;
 spf=none, err=permanent DNS error (domain: fpond.eu, ip: 81.169.146.163, mailfrom: uli@fpond.eu)
ARC-Seal: i=1; a=rsa-sha256; t=1733292474; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=BbH8eepUbvOFzKv3K0lO2/xRCPFi8KU4/kCgqqzdPjzBC11PcKyWojwfEcn2YJ4lh4
    gYDkQJ88l88VaiX3BOVewL0RmEdNv8bKKo0bENzcP0To0LOHXTk/ZmT1RVU/af1rBZys
    //LsPnURYUAjIQv7d/QcqxR8inEw8/QZhtNhQBseF4evoFHXTIJV94/R19JpkVe7uZPH
    isvd4/a5fsT5dr/jCfaNtXEqMMN0yGnXfetOy2l+76LBgawRAffIz7XoqwjuyRsjPxxu
    0rdxiNGjqUcSRXx9y8WwR/jFWj8/d542aoTB19zJxbhGLne+6LmItnpWL+RYYvoXXPyX
    1Vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1733292474;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=3fsE5oKYBGuvCqFGTJoJKFrIE6KgU8L3PdwR1txOPqU=;
    b=bGa4j3+8Ss8lwq2s83NYBgLSueVOJXxlc25Z4KiaLq4bzg4Zo8IyY6P+r9YWHQl1Ck
    JRJHbgMaEq/E4zP7Fhm6N/zWc03/IyQAfL22mXHDTaqwCd5Q68rFQ+Ixr8wFjKvMQTWS
    YleYBPxLVXxAL0T+ad/fpVdmruRYflM8Cv8G+BR+ZNn6uyO1dNUpVgcO21M8a25+B2hz
    HFqPT4hGogrC9EIxrSpF1vVRsJq/CVhQ4+3Y2hMoVQB1ntO4voOk0yzlIJhfSkCw1kik
    2JlHm2wuhotvaR/uBXVd/sluU9vIefX02xlxTrTqeKhQO2KIHVmnXTEcng5h9wpl3yCs
    lZdA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1733292474;
    s=strato-dkim-0002; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=3fsE5oKYBGuvCqFGTJoJKFrIE6KgU8L3PdwR1txOPqU=;
    b=ooJoXKX1rdpSJj0PaqxTUFjkLLkaKgfI+xH7429oMAdJWG7TmF8ex2GkDAL6uHme+b
    OHsyKRXK23zmz/nVAFwlC2epqulsAXvnwtzSM+XpDK2GFxKPmMyk2mgfJb7PEKPPfPpg
    shsjnBN0PrEqQW1JeyY0yYF54OisFFTZtbBuj0aY9MTm8qAYV0phQJyFCymP2WNPzLko
    GVTKuAgOUyCPjq6dRLevZ7ekIi+VaUnLtPw0RwbmZTWMa65vbwec7XiZ+iLuNnY7agX5
    gqwyMWq2W3LT9HAA0fwds+mB3XgGxFD8/wOd7fufBYlOPGWrafAM6En+cbgXlx8lujcJ
    ybWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1733292474;
    s=strato-dkim-0003; d=fpond.eu;
    h=Subject:Message-ID:To:From:Date:Cc:Date:From:Subject:Sender;
    bh=3fsE5oKYBGuvCqFGTJoJKFrIE6KgU8L3PdwR1txOPqU=;
    b=faw1htT9QWPVTkcjFZbm9GWOpkF1PyKBqNCCd6oqcbF6lA+EcGMsFzS1WoxGHn7mPp
    TujID+SDRYqunWZBb4DA==
X-RZG-AUTH: ":OWANVUa4dPFUgKR/3dpvnYP0Np73amq+g13rqGzvtHhj3fsqaR1GvSyJdw=="
Received: from ox-live-app202.back.ox.d0m.de
    by smtp-ox.front (RZmta 51.2.11 AUTH)
    with ESMTPSA id z9fbae0B467s3wn
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
	(Client did not present a certificate);
    Wed, 4 Dec 2024 07:07:54 +0100 (CET)
Date: Wed, 4 Dec 2024 07:07:54 +0100 (CET)
From: Ulrich Hecht <uli@fpond.eu>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>,
	"nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>
Message-ID: <1473272532.942564.1733292474812@webmail.strato.de>
Subject: Request for reviews for 4.4-st59, 4.4-cip94
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.6-Rev70
X-Originating-Client: open-xchange-appsuite
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 04 Dec 2024 06:08:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17324

Hi!

To avoid lag due to the large number of patches in 4.19.325, and to bring the schedule back on track, I'd like to make a release based on 4.19.324. It's quite small, there are only two manual backports to review. As always, they can be found in https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=linux-4.4.y-st-rc

d8f1878c3b912 dm cache: correct the number of origin blocks to match the target length
23f883c06568b sctp: properly validate chunk size in sctp_sf_ootb()

Thanks for having a look!

CU
Uli

