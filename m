Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70558C433F5
	for <webhook@archiver.kernel.org>; Wed, 16 Feb 2022 13:58:18 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.web08.12049.1645019896820546559
 for <cip-dev@lists.cip-project.org>;
 Wed, 16 Feb 2022 05:58:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=quirin.gylstorff@siemens.com header.s=fm1
 header.b=faC1ErXj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226,
 mailfrom: fm-51332-20220216135812332a08afcc2c1097db-45top3@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20220216135812332a08afcc2c1097db
        for <cip-dev@lists.cip-project.org>;
        Wed, 16 Feb 2022 14:58:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=quirin.gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rdxFNVjUM4DYZhRjnuq0zej8/yqh1ULUkgyExn+ynfw=;
 b=faC1ErXjfit1/OvflV4Mtz+mfNqpROkPgezc4qlZJoO8oMoUdqJ4UYXotkBfDHchJ5BJrv
 RKGCd8irVwerS3PeMSv/pg4Jsn3WMRmYidm8B/T202qVhZTzgvj7riA76TTvkDAvvEvUXsnA
 NhrfABs+U6YSXbFSj1w9e5UyJDY38=;
Message-ID: <32fd5db2-71e8-9251-e3d7-659806339910@siemens.com>
Date: Wed, 16 Feb 2022 14:58:11 +0100
MIME-Version: 1.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/2] Update ISAR layer
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20220216130317.3018990-1-Quirin.Gylstorff@siemens.com>
 <337dd7d1-7e8b-7f6e-d094-fc33c0939283@siemens.com>
From: quirin.gylstorff@siemens.com
Organization: Siemens
In-Reply-To: <337dd7d1-7e8b-7f6e-d094-fc33c0939283@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 16 Feb 2022 13:58:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7622



On 2/16/22 14:46, Jan Kiszka wrote:
> On 16.02.22 14:03, Q. Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This Updates the ISAR revision cf3f18a649ff42726677a58b224b9bb58ea4ba46
>> and converts the swupdate recipes to the usage of DEB_BUILD_PROFILES
>>
>> Quirin Gylstorff (2):
>>    Update ISAR to next
>>    swupdate: Convert to DEB_BUILD_PROFILES
>>
>>   kas-cip.yml                                          |  2 +-
>>   recipes-core/swupdate/swupdate.inc                   | 12 ++----------
>>   .../swupdate/swupdate_2021.11-1+debian-gbp.bb        | 11 ++++-------
>>   3 files changed, 7 insertions(+), 18 deletions(-)
>>
> 
> I think I will have to fold patch 1 and 2 - otherwise swupdate will
> break after applying patch 1, no?
> 

Yes, folding would be better. I used two patches to provide one to a 
downstream layer.

> Jan
> 

Quirin


