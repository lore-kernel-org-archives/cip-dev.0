Return-Path: <SRS0=QQsk=PB=lists.cip-project.org=bounce+64572+6819+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0FDDC433F5
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 14:01:48 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B0E60F94
	for <cip-dev@archiver.kernel.org>; Wed, 13 Oct 2021 14:01:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45B0E60F94
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sgPZYY4521723xCE9hbxwwE2; Wed, 13 Oct 2021 07:01:47 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web12.8574.1634133706688798674
 for <cip-dev@lists.cip-project.org>;
 Wed, 13 Oct 2021 07:01:47 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 19DE1icT017267
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <cip-dev@lists.cip-project.org>; Wed, 13 Oct 2021 16:01:45 +0200
X-Received: from [139.25.0.14] ([139.25.0.14])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 19DE1iRh026925;
	Wed, 13 Oct 2021 16:01:44 +0200
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 1/4] swupdate: Move handler to own recipe
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20211013134053.1400723-1-Quirin.Gylstorff@siemens.com>
 <20211013134053.1400723-2-Quirin.Gylstorff@siemens.com>
 <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
Organization: Siemens
Message-ID: <34ab1f03-a798-8d7d-c616-496846c69e56@siemens.com>
Date: Wed, 13 Oct 2021 16:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1094a516-23d5-cc51-e787-d13c2f42acde@siemens.com>
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: E9pWyZxqOZKSTIgxsUVe4VoOx4520388AA=
Content-Type: multipart/mixed; boundary="uEU6T7ykcd6JZ5LIElmb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1634133707;
 bh=Rx1wTH0w/QdINePb0bcbbWVrR9OQXItKOW6hdV1xIiQ=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=Ipk8pCJSwXVZ2sUORp7R91R3MlwCaCirdoqn1Pb0NbtK2rsyR/CKtcoICKdExt/649o
 Q/HwYVPinDVNd7Ao05upSkrfuazG1rA0pYbAErISI4VJzuSRS2Hc6CGzomHGJwQGsDk31
 /XkQ9Pd41NYwztPXVE8/nE6djndQZTjrJgw=

--uEU6T7ykcd6JZ5LIElmb
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 10/13/21 3:47 PM, Jan Kiszka wrote:
> Plural or singular? Can a generic swupdate-handler package container
> multiple handlers? Or will it only ever provide a single handler? In the
> latter case, make this "swupdate-handler" as well.

An handler package could contain multiple handlers. Currently we have 
only swupdate-handler-roundrobin.

Quirin

--uEU6T7ykcd6JZ5LIElmb
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6819): https://lists.cip-project.org/g/cip-dev/message/=
6819
Mute This Topic: https://lists.cip-project.org/mt/86287949/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--uEU6T7ykcd6JZ5LIElmb--
