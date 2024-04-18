Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 548CFC04FF8
	for <webhook@archiver.kernel.org>; Thu, 18 Apr 2024 15:55:29 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.87])
 by mx.groups.io with SMTP id smtpd.web11.2287.1713455724379670645
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Apr 2024 08:55:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=M0JdhB4J;
 spf=pass (domain: siemens.com, ip: 40.107.104.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOrnJ/o21cs4I5lVFlAZxMGipDisSAqmUW8M/wlWbHHfOZUTEQqk2Iqxiw4DrCeenAljxqTbxhie+eRE5OMXYhRxTBUtsPVpyzySL0IZiDgVwv+kRBG3rvtqsH9+EPTe03lYgjZgXoEznhoFZr6LzYLBvy+0GGp0btFkNi0/ohihoIjNiApJXNr3pwMkVBJO2gLozGqOYh2oKBUkzUgLWCqFpX1eNrHFb8EPwwBmwoNIVX1V1hCiUd4CgkAaqASOySSjT2wS2cgq2lR8xfrR4cd31E4ZUy2L6mwBJjXUzlHPLrrxuf7PISVetPAO7mKFNQhOTJO7VSwFH32+QCEarQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLJxHI8LvoSDmtvaP2aUmJnL00l+JcUZRUfhYZ34R5M=;
 b=Z6pi3dw//WpOsd5Go7dclGivqsB334XfT3SCqBATvlUe+5wzjt6G/yoWzuhs8QzckK1P9nQh3eIxehb2lQha7EpBdEMY2DsbwD0k7ZYRhR4BHzJs0Ya/yWQXlwp4rPAAUcxyuqfm+F5RyUXqrHlrKLeueiONCSXKX5r3FhOwnRJTo/0rRp1lA2fJUV17c7FQ6UjcUCPYCVHffA4SNk3EotL3l/tlzzPp3kH1syD86n/O25fZ4qU3GdKc7YFYZTMl7C0kQKuumQIGVqbOccFuums2LtWhTup3cozycP7g+c9Ei8y8XKXYAjGs5dzczA91oTWECaFgf+M+e2vMt3PuRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLJxHI8LvoSDmtvaP2aUmJnL00l+JcUZRUfhYZ34R5M=;
 b=M0JdhB4JkHkXQWXEb3w+sXouKPPASq+ctEmo7DROZP+0vHIQLilwIPp4zSOQUxV6FFRvs7xkIRinLd45H+LDvGN3pCvvW59azYqDSsvPj0UWgVHxn5rE7TQ3o1sE0pMPMNV0ZhAzd9UvTyniezPb4NYSuncfw/EEM6uwjgyA7AtTpprz2+o5CmKzZKMd7P8L8A1sdrdFY5Bnu2PWJ5KCfZJaZTUfGpzA35SxHP8iI/IDu2CKvrhImyD1RW+mgMlkZHYxZAxXfuBbEfdqwrKIOtadWrDthRKTbt9RBjOmmPXFS5zu8mpE27XL7rx474X+Ws3E9ctegMdszD8ZV3yGHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS8PR10MB6969.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:57d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 15:55:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 15:55:20 +0000
Message-ID: <dc8f8575-1477-43d8-8adb-a20c49ea997c@siemens.com>
Date: Thu, 18 Apr 2024 08:55:15 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: IRC meeting
To: cip-dev@lists.cip-project.org
References: <CANgtXuNCHPcxu1p9NTs=-8n_Gb3B6i2PEn_3od92c4wQgt+pGg@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <CANgtXuNCHPcxu1p9NTs=-8n_Gb3B6i2PEn_3od92c4wQgt+pGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0139.namprd04.prod.outlook.com
 (2603:10b6:303:84::24) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS8PR10MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0b6704-a4a8-45b1-0c92-08dc5fbff2ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eGUQHVVSOh4BvV75jw+vlTBvn+skI/gegMyKjlUYx8ZaFWzpMCAjeHR52rcf8rjvKPXj5wx5O7MzF9SsNOyzRQpY7xcVXLfh+0+v6m4hxjzqba2p7zv3iGO0PFgo66kMcRPH6/2nWGSKPh6Czn2YGqkKCE3MJKZMBJKIXCWJQ6KyXs/owjORrOW8gya1ZrCN+5ZbmN+iVs7hIxyhHq/65sIQJiVCT2XTsBGsUtX5bVRlDqLkbFWiM/P1QHfcew0poTzb1LswUAzA40brzJtN1kuLzPbj37npDt9oefKq0G31NQwCuAyYWTAdMQhsiye8mMENsThm5NpUnZLN/0V57Gq8yT0mjCKnfdXSGGoYNts0AnDv7ai9WuKQ2lSeF+Uhl11pZu+hDXdM1o1AHzenkEw/vgGS1TTC1sc3ageegJltMrEzIB/wtk+BNWmEiOwZiAXCElR+l0s21i1BxDzcmbMqNvLXdQ1kYbb5gyTM/apiJTsRT3JYXX+DiS8br0OTEnr01uSYbidGc6Y7/96eydcwMfRNssrbEvKP5QEgM/q+B5ie+SQuIu64YVRakgfIxFfBBJ5yUt3o3/EQ88gkZSdlB2J5DdwiMiXspDkYApLflkvPvgjx4NhLKQdaY5VNHrIhGkHtdpbiNFifmzLgKgGYxZg+7kRMxwntfq4GIUU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YU1iYzdPdElOenlVcDRKNm9jbktQWDJhSDZpdERKbWlLT0RaeGlzNDNVSi95?=
 =?utf-8?B?N1FmdkJmclN5cVlQTmcyNW45QU1LQmdKMnYrYldVZ0pNbWxZcHBQWUFENE5C?=
 =?utf-8?B?djgxYVNXeDU4N2dCaDRzUXUvbXN4bVpPVGI1VFNDaHNXQWszdjE3aU9NWVZw?=
 =?utf-8?B?T3IydjJKSHNFd05GUXNpQTlCZFM3bUNmK3JuRFFPTktCcytFbmt3Z1ZMbDRM?=
 =?utf-8?B?OWhqVERZVVFudmhGUDlrVkdxNlFtaFh1b0MxcGhaczlSU3hZaERCcXkwaG9D?=
 =?utf-8?B?RkM0UE9vdjBPVXoxc0sxRHBwRzhTcGNMRTNMMDM5UWRzb21rM1pMd1pvUUFJ?=
 =?utf-8?B?QnhDWjlIbS9zZ3Iwbm9SRmdOa2NDYVhYdHhGSUhYZFVLVEJLNHlzMWgrWGpN?=
 =?utf-8?B?R1ZzRTdEWVRFNElmU0szdzljQW1hakNYMnVnUm1oSmV1cC9vUXFWT0RzU1Ft?=
 =?utf-8?B?TmtETnRwQ1dHWUthcHpnR2M1WmhqR1c0OG9Obm01azVNb1pFc0ppdE1EZ0Yx?=
 =?utf-8?B?bEdXM3kwY2lyNUk1RXRQT3RMWlc1YTQ3UENNeWtqR25sRjQxQmF5L2pFN2V2?=
 =?utf-8?B?ZktQalpwQTkxT2xGd1pFemZkWEpCV0pydXM1VENRb2hzeGNHanBZZXdpQkc2?=
 =?utf-8?B?SDlnczh6RnVqTjFLYXFjeTJNUzNRMVJHOG10YzBMMm0reVZtWVBIeEwybzBs?=
 =?utf-8?B?cFRpNHY2SDBxNU9ZNGRlNGMzQ0RQWk54T291NkI4NkNCKy9CK0xncG94amZn?=
 =?utf-8?B?NWVrZnoveFZrUGVQenhQaGhCL2VwalpSYUhKcHFXSFJGNjF0NVlPMzc1THZZ?=
 =?utf-8?B?OGcwTUtaK00wZkxhcy9xZ3prSFFSWDZ1SGhITE5IdEtpMEVQYTBDQVRCTStU?=
 =?utf-8?B?WThIdm9YVFNKTTJ4WjdxWEFUWERMajkra2NsR1o4MEpBNWZGT0k0cWw3Mkdk?=
 =?utf-8?B?NEtNVktzSjVwQ2xMbzdTZDZsZnM0Wkd5RUxoYWZudDVIMVdQMEJtaTFsbWIz?=
 =?utf-8?B?eEpxTFBuSUxsZUlSaENmQUxoOGxUbktkLzgwY2V6VnVOT1VhbjlaM1VsTjRP?=
 =?utf-8?B?QVBNRVU1bTlPb2NTWmFxcjBralFHMVhneVhpdEFrS2JidVV3UW0rdTc4aURh?=
 =?utf-8?B?bGE2Z2dDN1hOYy9CR0c1L2RaM1F3VnNYUXgzcTdsMzExaEx3QzRGMnRublJV?=
 =?utf-8?B?OTFYeHBXbms4MkZLYUFxdGNMa3JqeCtPSjlBSE5PQlkvME5BSzVNeWd6SmlW?=
 =?utf-8?B?T09qbXNWMERteEkxQ3BZTFhaWjBXNkcwRGlFNTh1NlNlV0JGckV3Zmk3eXdD?=
 =?utf-8?B?alIzMm9ncEd1Y0JRYXZ5MTVteHl5ZGc3dTZXZEYyRkJDMzNMcUUvbGpyQzdZ?=
 =?utf-8?B?bUE1STNTelAwWUNRM00yS281V3JVR3U3eUVISXFFTnJ2Y3VJNWIybzZFNVBK?=
 =?utf-8?B?YS9xdXZDWWYwc2QwK1p1TEhManJuTC96OHVONXU1Y01FMnlDZGkwdDVNTlBI?=
 =?utf-8?B?WHVBUUNnMXYxdS9KWk9tMGlLMnY4Wm83eUJYbHdlbmJKcGUxbzR1enRxRlBq?=
 =?utf-8?B?Snhaa2lROHgyVXl6YXN2Rk5oSjVLM1BjcHpXQTVkbkRQTGs3blh6MUhPMWlK?=
 =?utf-8?B?b1JLb2xhamx0Zkp4T0h1WWVkNzhaSlU3Z2dRQTBHM2xNQ3dwY3BFUk1pT2Nx?=
 =?utf-8?B?a3oyOHNnZDhiWkRMRURaZDYwYmdNOW52UW1nV01UWFZGUTNnVkVJL2p3c2VM?=
 =?utf-8?B?b2lBcjdtVzF6UEhvdDhtYjBacCtsSUpjWXhpUm1ueW0vOHBwd1ZtNzNWUmtx?=
 =?utf-8?B?ZEdUb21iNGZkWXJkakNMN2hTeGpZTjNEQjNEK05QeURMK3VHSXBuMUFMTWNy?=
 =?utf-8?B?N1BxKzBPNDRZdk9xWTlEM3VGaDJ6NWtNWVluUnpNODFYRDhqTUVvOXFxQWFw?=
 =?utf-8?B?MXZGbEpxd3lHUVdTQ0ZVNTF0VEdESEw3K2xMbXFBd3Fvd2ljN2tNZjM0cUZw?=
 =?utf-8?B?V0hMZ3cxeitjRE9Kay9PSHZHR2w1WGV1UWpUTG94dm41ZDZ0anpiRmdXOVJp?=
 =?utf-8?B?OEdQcUZ3VWo4SFROT29TMjBxQ1JmSnR6by82VlJOR0d1UkxUMFA2ZjV0Z1lU?=
 =?utf-8?Q?JIJHINNV0OQ7P3+cBSCXd9NGi?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0b6704-a4a8-45b1-0c92-08dc5fbff2ce
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 15:55:20.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q5Lp40ewkBpxl7XXEOFO12u4O0tTdKN0vM7wWDx/uB5UNq/HqPYADn9H1lu3zJ4qFsouJYzjUjIFDDGfUgLDNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6969
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Apr 2024 15:55:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15581

On 17.04.24 08:04, Arisu Tachibana wrote:
> Hello
> 
> for personal reasons,
> I cannot attend today IRC meeting.
> 

And I actually overslept. Seems you managed it independently - thanks,
Pavel.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


