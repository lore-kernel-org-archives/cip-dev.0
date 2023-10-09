Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B3E2E95A8D
	for <webhook@archiver.kernel.org>; Mon,  9 Oct 2023 06:03:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.84])
 by mx.groups.io with SMTP id smtpd.web10.55247.1696831401182830596
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Oct 2023 23:03:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ntXh/O/o;
 spf=pass (domain: siemens.com, ip: 40.107.22.84, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jt7JJdUHKli1LaDcvsG66mGTfeaW2Xj5NIlzvcfypv4KfDe6x8+gnY1Nma9fnqUe2qV+3Ey9i1W+TcY0T26zRU/NnkiUSlEqG27XaowmiHcJaZRmzeQujnI8my58g+0O6d2w49o6vDO2kW8DTgLQ9YgtuF/vopBiZWDUneNyCSrt/EcrwbbBvq+5l/6UrajS9HXZSx2kewYJ7YeuN5YNMDp3Fxq0nblyOWjvW1lV6Pp+7czQGhWld95Zk0SgIUcwGdAOVu6/MuDkVYlb+VKglY/s7V/zQnX8bEZ/R8DMR/93LOcRGekpJeoQgx4BNfeTMPtiXBknmyxz6VkIhppugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qj1s9fSphQ9jgZMZikr4aC3w9zxP20EF+W7pHB8l3zk=;
 b=AIwE60CftVhmA1uUFmtvY66s95bCl04Emz7yG3h5oN1zWAE/6m77iwDE2wUYba/WeQ0nWF/v8igtIyRarhd7owH++e9KX+M/AupnxHms6LZhocg+WE408gDkSkyi6XOJSdZFxb/NGE2c1/jCwneJodTPfj7QRF5qsWPxVjb18Whak5kOI3XwiRc6m4ODr++JxI8iGByw41Mu2RgrST200/BCSAQidG6a8VFOFOo/s2h9FjEusPLBxAVrOxvNBctryLzhyWVcpZT582+J7cloEk1bJyQfIx/EDOc0bn34YLvVuJk2+47xkOCSaRlN0MthSJEaer63GEKW+9rCmSNmuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qj1s9fSphQ9jgZMZikr4aC3w9zxP20EF+W7pHB8l3zk=;
 b=ntXh/O/o/R2rY236Gmw0DUWZNFlHXqSsfniWd5FnGn2eZBSSTo6s9oYKwxN3NW1TEnqh8Z7nwYTXpejvXdMYX493H9FhK5Q2tGte/YIhk1H3zwhpJ2xzjC8DJE9n0KGor9kW5e+hZPgVy1BmEWVmZ41le+8xEQJUhUkA/uwiciQboaoGt9X1WIs0bwKfaNkCUuhv+/K6M3ku4/Q6xDbrDFX8Dvsbkfy12hDXPIzSZ1NQtT2bDWU6aYMpMX5L1YMndsJdWkA58+eqygRJ9F/LnQGtEPTGpQB36IhsH2ChFHnddIYo5y+MXQJZxRUZtNbzdRnVgCBle7nbFvacGRqjYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PR3PR10MB4029.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 06:03:16 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3966:eb27:c3d8:bd10%6]) with mapi id 15.20.6838.033; Mon, 9 Oct 2023
 06:03:15 +0000
Message-ID: <c068e40a-4845-4a8a-829f-2bb9ad1c3b40@siemens.com>
Date: Mon, 9 Oct 2023 08:02:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 4/4] update ISAR to latest version on
 master branch
Content-Language: en-US
To: Felix Moessbauer <felix.moessbauer@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20231008031529.1338834-1-felix.moessbauer@siemens.com>
 <20231008031529.1338834-5-felix.moessbauer@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20231008031529.1338834-5-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0248.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::7) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PR3PR10MB4029:EE_
X-MS-Office365-Filtering-Correlation-Id: 500ccad1-9de9-4d9b-9e6b-08dbc88d443a
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2qiZoeh11ro5qEKoGfIKVu2b6cKe5OOmISbksgph+5OPaZH5qVzbyOeIfRbi4785LnrNM9YyYB8B96AVmfoWPA0JbnAMh5PAG9hDcRlIG8/bcsAX22Uu21Mi4f/7sp7i3z15GqvQm0pK4NU/nW0QhiBltC/5RYf5TbNr7ranJpdEJlOjghktn7mlMWtmDyO3dHsw6isxDJCqR1GNPE4FZKa0exMs7wGUZ9EibgUXj28VrTkfQgkDDhtjytthJJIKPqAFzOeYFRKpgsL4L8oxmWvrdEE24ORtSQAF4EUgg15q+cBuTo+lLKwm3sG4cKcUIM/GgZRoJ48prRnrWtxE1DkggmTR+YQ6z0lbyKSNWcuScf0X955LjQKp6kCi/VyzXfJohmbvtcqYaGBQlW/mIq4wdvBRvEhmMa81F3n04PzDFFRe2B86KWdNbpJ2LVTP/bPc8a0l2LRWnpzigDoFHMFO7ltNzswKPyuWqxb4Yf9UFz+qZV7TGAylNZuT/na/Waj50mDFciJ2t5kAqSZDueBq7jvGk1tcXL5+PvV3XcsBLC9/dk9qrBNvEfIvUbQJwYZama9kaUsRtjy4JAabyHCo85IwB+mQdScbmWsSoOaIzDkHipBYK9EZIylZYXnsdM+oFxezbBZyD7gAdS8cYQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(107886003)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(44832011)(6506007)(53546011)(6666004)(6512007)(2906002)(4744005)(966005)(6486002)(478600001)(36756003)(38100700002)(82960400001)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnFrQU9paGk5V0RsMkYvOWt3Q1RidWdKYzBqT25mUFRoak1MbzlHNFdjRWpE?=
 =?utf-8?B?QVhBRE9hMnltazcxVW5zM1huUDNMaHhrREVhN1ZnemswTkIvVlB5MzhYY201?=
 =?utf-8?B?LzA1UFNUTDFVTGtWdW1GYUwzNWZsemVvUXI5ZWJsT1d4Ymc4NS82a0Vhcy9a?=
 =?utf-8?B?YW1ZeE9lMG1ieGUrbHllR3Q1aTFzTUcreEZJNFlJWHljVHRxWWYyZ0JpRG9F?=
 =?utf-8?B?TTNVQWR5K2I0MGxIcisxQUgxZ3dpajlzK3k3SUlISVA1czRua25aVVpuS2NW?=
 =?utf-8?B?Q0ZWcVgxTFJpemhOVkRjRHdzY1dVSm8vSDRTZ1lITW5qbHFnVVVHbkxFMzBN?=
 =?utf-8?B?QXBOM0VscXNvWlNHcmFDZHcxaDl6WWcxczRySTFlRTgwMlhhTE93SU5UR3pI?=
 =?utf-8?B?SkF2VGRKMHVqQzZ2bHdNNlVjNjVHSUFtVTl5SWtucHIyeG1WVkhaMjI0YmFr?=
 =?utf-8?B?blJpd2NRQnYvMzNDZEVsZjNzeVVldGZkVDA2eEZtdWxTZkdxd1JoRzJrb2Nu?=
 =?utf-8?B?OGw0WHZzT0VZN0RoUHp6YjRDQzdkQzlYOFhUVEx3MVJHeWErZm1pRFFlNk1r?=
 =?utf-8?B?NlBsb0htSWM1ZEthaFVBUy9zbGVTdWY5L041K2dkNjVnRU8zTVhVOFNXeFdn?=
 =?utf-8?B?N2hhSXo2WGFCRTRpZ1JXcmZxbmgyVHJwWVNLdVRVa3hYbG8ybHE5cEY4TVNX?=
 =?utf-8?B?ajNHbjVqcXc1aXN5YXZWYmQ5dEpzbXkvcWo0NE1zSEIyZWxGV1pDTklMZitZ?=
 =?utf-8?B?OFQ3RjBUMldIY2ZzRitYQTdVaUZsZmpiWGloU1JGWFl2OXB4aDRUbm9xTjUy?=
 =?utf-8?B?SFl6TlViLzZMNUhIUlZQSkFkcmg5S0tLbEw5WUhmQmVIQVF5aGdoVFR1SG84?=
 =?utf-8?B?ZE9IZXYvZVBEQWhZQS90QU90c1FTQmZMNkhyb1JYdDVkNldTd0pMcnVHOXRp?=
 =?utf-8?B?dkRhaEliZnZUUzNKbTJYT3dNRWVzekxCZEQ5bVZUbkxqV0hxYXpYVDZWMW9l?=
 =?utf-8?B?Z3lKUWVDKytSVDcyYUVEVjlJVm0vMkRUS1JQVHhnRC9NaHU4cjFvTnVtdlFK?=
 =?utf-8?B?MDdUeFpqUXdPZmp0QVhlZjZoVy9kTklTT2pEZi9Fc0NtdDk4eHFxdlJybTJw?=
 =?utf-8?B?cVI3WnQrUjBMYlF5c3B0ekhUYXFCaHlhbzNYblZIUTJVRklpbGYxNlZQQmRO?=
 =?utf-8?B?YmFVOFhzbEljME1KekhhcWYvaWYrVVNBazR1RkVySHlielZlYVBMMHlSN044?=
 =?utf-8?B?KzhMTzFSSHlnR093Z2ZGendmQ2NBMUxzc01IYjV2Y0xkQkd4QWNWOGprWjRP?=
 =?utf-8?B?UnY3MFhCd2NVQzJkL3RiUWw3QVJ1U2RkM1hWR211Zm9kZHExZnB1cXNzOHFY?=
 =?utf-8?B?ajkrWlNaSlZrc2JJejQyeThRdkl5c0pBemIrOVB3bXBHWXdHU0xEUnJuTkZq?=
 =?utf-8?B?VVF4RVdiNW1HYWZoNlVmVENpWDIvTEVNRmdoVElUMktPanJ6Y2JNaFJ2WDY5?=
 =?utf-8?B?WWVjK0wwcUszS2FiY0dwVk9TSW9Pc1lKWW5yTmNjaE9CQ1hvS1BZSE04NkM2?=
 =?utf-8?B?Z2YzMW5PWlVpcVlOVHZqOENSTTVUUG1MekNaVXUwK2svZXJRQVBCQ2lnVUtr?=
 =?utf-8?B?MDJ5NWZ0MUphRnVtRFptM2sxbFkyRjB1QXVHYzUxamRyS3lOQmpqQmg4YjZj?=
 =?utf-8?B?amh4SGpJQWhkQlBheTQvckVHTnc2Slh1NGlFK3pYUlpsUjN3ZVdCM2tGWnpB?=
 =?utf-8?B?Y252TzNaQktkZFE3ME5oak5kZDU3U3VUMG5JQ2FReFBqVW05TXlwMXFIZG5W?=
 =?utf-8?B?YzVtVlZHck5xcHkxUTJDMG1KSENoeDJQS2JkVG5RWFFKeTBnd3h6UWdldVNh?=
 =?utf-8?B?MmliamxobjFvdGdBT0ZvUnBvSTlQMEVxZWV0eGFkOTBoWFlGTmcySFMxVHJS?=
 =?utf-8?B?UlhKaEZJVEhaRzJ1aE5NZ094Q0JTbk5kd0swVmJNQkZlUEJRaGdaa0QzV3Jp?=
 =?utf-8?B?QTRnZlVDYWxCMFZMTFN6OTVZUVV4djFtUGJneVREOGs0clFLRVhtKzBKblJt?=
 =?utf-8?B?R0taeWROQ3FCRGNrSHoyY2tncUNwdDhrTGxBbkZmVmI1L1NhVG1lMzV4Z0x6?=
 =?utf-8?Q?D4BxYTD1GPvJ9XNB2pGOSs3cB?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500ccad1-9de9-4d9b-9e6b-08dbc88d443a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 06:03:10.8717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hu9MCOp8DKtPqaSKXoMEJ+6rbcR7/y9PdPFiyaybyMdOh5yNW4vUdkV9jdRn0iDkmH1Kwy2BRv/dTyN3BJskHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4029
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Oct 2023 06:03:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13314

On 08.10.23 05:15, Felix Moessbauer wrote:
> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> ---
>  kas-cip.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kas-cip.yml b/kas-cip.yml
> index c329248..84b7441 100644
> --- a/kas-cip.yml
> +++ b/kas-cip.yml
> @@ -22,7 +22,7 @@ repos:
>  
>    isar:
>      url: https://github.com/ilbers/isar.git
> -    commit: bf9c9fdd99bf26dca25fdf9e63b7eb5b053d962f
> +    commit: dff8ad504b54a4e292a1b986cdc74ebc9e6e177a
>      layers:
>        meta:
>  

I'm inclined to fold all four into one commit because imager_run is only
available after this bump, so this makes the series non-bisectable.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


