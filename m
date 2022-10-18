Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BD6C433FE
	for <webhook@archiver.kernel.org>; Tue, 18 Oct 2022 05:05:38 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.79])
 by mx.groups.io with SMTP id smtpd.web12.3529.1666069533654865800
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Oct 2022 22:05:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oRObNLWa;
 spf=pass (domain: siemens.com, ip: 40.107.22.79, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3j6XYSdxiPwbwptmY+x6rNxuyuZ5BV+5kb5cs0LP5t3mosB9Spo31akeZ0hLSsekcgX53dqCdPJapcX6ObYVdssMOGJghfKPDEhqlwtNPyQ5IM89iHvd6DNmnRjVyhk5Qd7uD3d7H636Un2I4X4S7Ie8kM4rWDgl122HpqByYzmO6r6PUDhRzGwKV+KawmldBORiQCWTwT2ivCubqEMZS74ZhjPqybBSTI0X+p3j9XdjdX56sAsvY07h8vJAie6h2YtCFSq7Wz0ozBRZg3VaW8H/ziiq9i90A//6WtUDgRhHPMi3zqdXIjgCUIqNP01nAPpNtbppNI0OeTSRY2faA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t4gMW2zM3tC5Rp5g7h0L4QYgg9EYgCNe9ycTs8CoRqg=;
 b=SysnLvPuEMhqCda4GitqVUQgIRYZ4W3+hnDC7TCKP+0AXKyQYIEuRztKNO0EQV5ORi3NwTk/828yHSEgQYfZLx3/1PvLnF4MDwvYzEiUzaId3AjM8j9UWDnm1ekbN/3gFZuB3T8cXvkG+1c3nClYN08d6l/eubXsXjaWl0DBotio1IN/wGOchaHKOBy1Q1N8hp+2TeNJT/MHpiEcflInzoFnUWF7T8zmKQeAg3ib5ycp2K4rG2dvf9SN1bOdVZ1uQNqkXDujmcqjHuJHD+AOikGhV5nbCArIoHqd594iyb4YX7bDRV3eA32bztx3KMiKbtOQO8+rjdrFVp8FqF6fNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=ilbers.de smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t4gMW2zM3tC5Rp5g7h0L4QYgg9EYgCNe9ycTs8CoRqg=;
 b=oRObNLWaVpE3Qy1T4PI6PQm0W1u8QGDdhS+vyTU+CJXfNpVqmmSJNL7I/MlXs57+Ti7yAVeoi1XiDnKQsWujO6AdZKVDOnAsUNeplYbVXZuosvJ4jeMzfsNVS/B3h15raWRDGKOK6Y/XiIdtp89eC9xAt53PC51TxNLO1vK+/0fvyluh5xhv7kSiZxXkAerbYtpNV8BDb5r/THKsv5KrRscNaZl3vZ/V0s7yJ+jb34Q2H96t33dxQKixeKOmJIMlTjO4lMQVhV3NhdLaIYHP2Wlsbz8fdpx6AcrW7ge4j3xuZOt0RuWtwGqzXj3UpEERiiZcXvO1tbNthpvbYwFDKQ==
Received: from DU2PR04CA0064.eurprd04.prod.outlook.com (2603:10a6:10:232::9)
 by GV1PR10MB6148.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:97::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15; Tue, 18 Oct
 2022 05:05:31 +0000
Received: from DB5EUR01FT080.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:232:cafe::f) by DU2PR04CA0064.outlook.office365.com
 (2603:10a6:10:232::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Tue, 18 Oct 2022 05:05:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT080.mail.protection.outlook.com (10.152.5.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Tue, 18 Oct 2022 05:05:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 18 Oct 2022 07:05:29 +0200
Received: from [167.87.52.112] (167.87.52.112) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 18 Oct 2022 07:05:28 +0200
Message-ID: <124d9128-63b4-d0ef-5cf9-7931a017e0c6@siemens.com>
Date: Tue, 18 Oct 2022 07:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH] Fix mount options passed to systemd unit
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Uladzimir Bely <ubely@ilbers.de>, <cip-dev@lists.cip-project.org>, "Quirin
 Gylstorff" <quirin.gylstorff@siemens.com>
References: <20221012111919.8911-1-ubely@ilbers.de>
 <34c6d0ba-bfe4-7b9a-d564-b7de58af8453@siemens.com>
In-Reply-To: <34c6d0ba-bfe4-7b9a-d564-b7de58af8453@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.52.112]
X-ClientProxiedBy: DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.020400-8.000000
X-TMASE-MatchedRID: EhMq+2gclHs5QaOxwNGfvo9bHfxDWoibdBh3bZKhFc3BLypRtAo4yET0
	lGtfbK/pBph69XjMbdlTHuQZZKa8u63aC25avUuavWpUlhrjisYHDvjr7OxGkI61Z+HJnvsO87Q
	rIQgH3y3PskTe0JV4n8i2pXmywZhRB2FcE7H+4RbJ/qoyWwJuecvXTWPjYDe9bl4CKqupkMr0VP
	vT0zx0mKfub87GOZij8P7ohAxHFTni8zVgXoAltkWL4rBlm20vt7DW3B48kkHdB/CxWTRRu25Fe
	HtsUoHuvd1sHcGLnkd7EHB987Bsyfw1BCelX3tXPu/RG47BZxFYKVgm72vjJg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.020400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: A48B5C68853C168CE21E4F472F6AA06E667CE37600E77459AF3BF108129FCDF42000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT080:EE_|GV1PR10MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: a61c967e-2193-499b-c204-08dab0c66117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	o+nLk3TkzvcTQePwJv52pQW9yVCA48azvIYD/oJU3cOlJluMT7Hmuj4+UoT55LeUvi4N3YI0iKl9C2cFiB0xZw/Kn99do/WX2yqVox6PFmD4VSbcM86l1A2Oqy79GI2abjWgndoOfXHdxX1y4zI96tKAU6NpqZOLzGDkqCTrlWdfjnYuTo20RiQ7BXy4/kCL+X5b7DPoHfkc1wS0MHpRmQK0A4YxnddWCeGnVrlmhSgnUUbq14BbGTkhgSG3n16YuDQ5DJH5Y1JgOMVwi1DExwLxPeNBsmAkuueD8HJEU1PFdQ74YcHTYYqfpiNykUVtEvXxVHtgid0sI3c/pmw6DL6v4y+pfN3uz7tvzeKoc4q8aJdHhmqzfTKd2F8eSBCBP+PY2UAyh3/RrPKtYds5a59zhZ/5GMVK6RMkMy5OlsyPOUe+SMRNp/qHjeeRe0hmzzYO8A6uoWgwTGuofVkAsseblKHzZsn4iXUbF2qWY/edL/6bETC/OKRrCWrt2l2RUWDiPzDyTCcs3Et703LmWxup3VPOBEJDJddWLhZgw3RvBbUTJqCfGk3UZB+DdVt0+xfx27GwrgetNV0L+Ybojl61YJ0RwbRk/ZJoPLd7iYLrVvoIgVpKSMjYptvaTfnUXYBKLAHOXtuO8sTmvn0hPJhr7Nas+TrX5PNUUgf8g+5BkukLPkmnWVxPumJlDKZie8cQGfBTR0ce3PvWERMhY9mshi63dPOlujOseQ6rsvfjR4EGASsItD7qqOj51cwU4GfVmPx0I26d5rRLXM4cH/PbuDV1CFINUXXWlTlItCfLkFsEOrdjasjJ5o9FmqjQNVU6UB75+Sn5ro1SdkVLR73gwaXV0pKNmHPw4MUeuQvjKyCwSeyTC2eaG7N7qhy4MU9h8GpBT6FdtMDCYqUWfg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(16526019)(7636003)(41300700001)(86362001)(82740400003)(356005)(40460700003)(34020700004)(7596003)(316002)(2906002)(31696002)(16576012)(478600001)(36756003)(966005)(36860700001)(6636002)(70586007)(8936002)(82310400005)(110136005)(70206006)(6706004)(53546011)(82960400001)(956004)(8676002)(6666004)(2616005)(336012)(40480700001)(5660300002)(44832011)(47076005)(26005)(83380400001)(31686004)(186003)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 05:05:30.4525
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61c967e-2193-499b-c204-08dab0c66117
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT080.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6148
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Oct 2022 05:05:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9768

On 12.10.22 13:34, Jan Kiszka wrote:
> On 12.10.22 13:19, Uladzimir Bely wrote:
>> Mount unit template used wrong variable name for mount options.
>> This resulted in empty `Options` value used for /tmp mounting.
>>
>> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
>> ---
>>  recipes-core/tmp-fs/files/tmp.mount.tmpl | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/recipes-core/tmp-fs/files/tmp.mount.tmpl b/recipes-core/tmp-fs/files/tmp.mount.tmpl
>> index fcb2f3e..be5e663 100644
>> --- a/recipes-core/tmp-fs/files/tmp.mount.tmpl
>> +++ b/recipes-core/tmp-fs/files/tmp.mount.tmpl
>> @@ -5,7 +5,7 @@ Description=Create /tmp
>>  What=tmpfs
>>  Where=/tmp
>>  Type=tmpfs
>> -Options=${TMP_OPTIONS}
>> +Options=${TMP_FS_OPTIONS}
>>  
>>  [Install]
>>  WantedBy=local-fs.target
> 
> Thanks, applied.
> 
> Jan
> 

Need to drop it again for now as the current value of TMP_FS_OPTIONS in
the recipe is not ready for use. See also
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/44. We
need a working default. And likely also a weak assigning of that.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


