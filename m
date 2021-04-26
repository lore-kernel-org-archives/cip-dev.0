Return-Path: <SRS0=HDzp=JX=lists.cip-project.org=bounce+64572+6396+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2A4C433ED
	for <cip-dev@archiver.kernel.org>; Mon, 26 Apr 2021 13:12:45 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01C8D61103
	for <cip-dev@archiver.kernel.org>; Mon, 26 Apr 2021 13:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01C8D61103
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6396+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id bmJwYY4521723xopZy7FdmiP; Mon, 26 Apr 2021 06:12:43 -0700
X-Received: from lizzard.sbs.de (lizzard.sbs.de [194.138.37.39])
 by mx.groups.io with SMTP id smtpd.web09.6549.1619442760996620317
 for <cip-dev@lists.cip-project.org>;
 Mon, 26 Apr 2021 06:12:42 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by lizzard.sbs.de (8.15.2/8.15.2) with ESMTPS id 13QDCUJO018072
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Apr 2021 15:12:32 +0200
X-Received: from [167.87.50.128] ([167.87.50.128])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 13QD8l24027774;
	Mon, 26 Apr 2021 15:08:48 +0200
Subject: Re: [cip-dev] [Inquiry for CVE-2021-23133] -- necessity of the backporting
To: masashi.kudo@cybertrust.co.jp, minmin@plathome.co.jp,
        cip-dev@lists.cip-project.org
References: <OSAPR01MB496166751E93E55A64756505A0429@OSAPR01MB4961.jpnprd01.prod.outlook.com>
From: "Jan Kiszka" <jan.kiszka@siemens.com>
Message-ID: <070cfa43-dc83-b3a9-366c-e07b122b6d34@siemens.com>
Date: Mon, 26 Apr 2021 15:08:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <OSAPR01MB496166751E93E55A64756505A0429@OSAPR01MB4961.jpnprd01.prod.outlook.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Ms6dC0bvFeMSMs5Y0Y6s92mzx4520388AA=
Content-Type: multipart/mixed; boundary="zws8D65vjVPhIH5QncEq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1619442763;
 bh=qI2RywtutNwodVmPFEU2YnQscQblZcMQ8wvmqFsq3/4=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=IzPCyThx8XwaE0TVZNKpimL82Xeq1I8++wKeQn8gkWd2/5hF4Mvz/3TaCIwz1yKqSZu
 vmUmiyDQltzyImHiNijWsBzWN0ZVvYy+Sswe7TGIZXvHGh3/J8PElBByug3i+lGunixn2
 KyK2282y1Vp4PuSjJBZ/BZTEE+g2K0QH29Y=

--zws8D65vjVPhIH5QncEq
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 26.04.21 07:49, masashi.kudo@cybertrust.co.jp wrote:
> Hi, Jan-san, Minda-san,
> 
> https://lists.cip-project.org/g/cip-dev/message/6382
> As was reported by Chen-Yu san last week, the following CVE security patch is not yet backported to kernels before 5.4.
> 	CVE-2021-23133 [net/sctp: race in sctp_destroy_sock]
> 
> At this moment, sctp is enabled on PlatHome boards and Siemens boards.
> We wonder whether sctp is really used or not. If not used, we would recommend to disable sctp for those boards, and we won't work on backporting this patch..
> 
> We are looking forward to hearing back from you.
> 

I can try to listen around, but I see way more users (based on configs) than us:

https://gitlab.com/search?utf8=%E2%9C%93&search=CONFIG_IP_SCTP&group_id=2748814&project_id=6052798&scope=&search_code=true&snippets=false&repository_ref=master&nav_source=navbar

In that light, a backport might be required.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

--zws8D65vjVPhIH5QncEq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6396): https://lists.cip-project.org/g/cip-dev/message=
/6396
Mute This Topic: https://lists.cip-project.org/mt/82371605/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--zws8D65vjVPhIH5QncEq--
