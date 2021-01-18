Return-Path: <SRS0=hhoV=GV=lists.cip-project.org=bounce+64572+6106+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F119C433DB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 17:15:20 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEADF222BB
	for <cip-dev@archiver.kernel.org>; Mon, 18 Jan 2021 17:15:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEADF222BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6106+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 9uIbYY4521723xJ3YflURdNs; Mon, 18 Jan 2021 09:15:19 -0800
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.36608.1610990118304450919
 for <cip-dev@lists.cip-project.org>;
 Mon, 18 Jan 2021 09:15:19 -0800
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 10IHFDMc028942
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Jan 2021 18:15:14 +0100
X-Received: from [167.87.43.136] ([167.87.43.136])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 10IHFC7L018272;
	Mon, 18 Jan 2021 18:15:12 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC 0/1] Move root password
To: cip-dev@lists.cip-project.org,
        Quirin Gylstorff <quirin.gylstorff@siemens.com>,
        kazuhiro3.hayashi@toshiba.co.jp
References: <20210118103704.18195-1-Quirin.Gylstorff@siemens.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <35eb9b81-8649-e487-b4da-b54dd50b5769@siemens.com>
Date: Mon, 18 Jan 2021 18:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210118103704.18195-1-Quirin.Gylstorff@siemens.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: duTrwRaL9yFpcHUM3hEd7ZOZx4520388AA=
Content-Type: multipart/mixed; boundary="oB4f47nGkcoJih3KnuKD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1610990119;
 bh=Nsbn6L3FUIXTcrhVID1rRk7Vl4J92GRwi2OdV/XPyxI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=mxGkSnkNgy6xThaedim3A9wwnoDvXHG+aQCHHAKDGDLcCa6Jxk28synzgPOcWLFi8pI
 19yDCC3YsVcEPeoL253LVwgtxzOUju1RQoPZQdPopDxX/Y5drzh5FW3WpOtll3EuvYF2J
 zm/16cKWIWuqY36BAa6qcGWPyM7emr05ckg=

--oB4f47nGkcoJih3KnuKD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 18.01.21 11:37, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If you use isar-cip-core downstream the root user in kas-cip.yml
> can set the root password in a production image. Avoid this by moving
>  the user and password to cip-core-image.
> 
> Should we rename the cip-core-image to cip-core-image-demo to
> clarify the indented use?

Not necessarily. A downstream user could still include or bbappend
cip-core-image while overwriting the password variable.

> 
> cip-core-image-security now requires cip-core-image as base. We could
> move the content of cip-core-image-security to a include to fasilitate
> the usage downstream.
> 

Fine with me - except that the patch does two things in one: move the
password AND also base the security on top of the core image. Split up
please.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--oB4f47nGkcoJih3KnuKD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6106): https://lists.cip-project.org/g/cip-dev/message=
/6106
Mute This Topic: https://lists.cip-project.org/mt/79920034/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--oB4f47nGkcoJih3KnuKD--
