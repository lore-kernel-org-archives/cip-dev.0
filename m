Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15284EB64DD
	for <webhook@archiver.kernel.org>; Sun, 16 Jul 2023 16:55:05 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.81])
 by mx.groups.io with SMTP id smtpd.web10.1338.1689526502750358500
 for <cip-dev@lists.cip-project.org>;
 Sun, 16 Jul 2023 09:55:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MIPOf2SB;
 spf=pass (domain: siemens.com, ip: 40.107.8.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0GJ9ITiOE/6UYBQWsZMbXa0P0GAZx9g9I8KMcrNt4U83e2bQnFY4kKM62OBNufcxTKeFDBNdwqqOU2ZyNv8FQtXG06+Amz0lSz2kAAP6NWabc/3bTIMMs39SB+kbNwv52Rh9VDT3Q22xKkPvo32sewJ5rvexQtkSVZRn+rCDOjqDDB9XF0XMqq+mym7r2uf5zWBJkHzAvM387O5NE58n1DcQ/HPdB4aRyRa/D1thFOuKhfxno49gGl+RROKqhBS0PNRaDb5lf+sVSjGiszZSq8neOX5m8KadPhnpajbyKGDj0QnpYYv9czEc05H0fUphrYnc2nS6lhjHbQEojGrBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE2G7LlxFj6M/AJfz8PJGuzSmOdFBPUytgcVq+hHIRI=;
 b=Ca8flC4iaTp/Z9KKqW3RIleaEJSvVa45KjPB4FzxSyq0zq1r4udBhQBjt+Y7HpfzJKS2Mn49mzZlJdjPWURF8dMsi6BLydRVoBfAahdAdf6jVSlShUo6aO/3aTZAAJ9pB+9CHHxiGxp9/a2CWAoEk24uJb1Ghyl1v1am7WM9ueNyz42pEvM/IXdiEBmtvO3Tbfb7uoQvjwlIx7eRICkdz6uRVAama9vMjK8K4N/Ua8FLBn1EmDHsSgLrNKdsIs6m0LqAsztJb6sdQLKOojIn6z7L6MzuXOsmhPHy/cadxNxMNZJMjVN2AIsBrh48wlOLV8pIq+vlir9d6wyq9bkvEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE2G7LlxFj6M/AJfz8PJGuzSmOdFBPUytgcVq+hHIRI=;
 b=MIPOf2SBhhjCeiI7T8Mzcw7YOJN0wmJnTuB3tTbSXE+wB91aFoxk16kTiAwumGfOkjT+CccYO6lpjFryKqfR8v6oG2InN60cScD1UGy4RjnTY9Il7SUIEjJxpxRolLj5iWex/BWoCu/WsLDWlfROwwcpykfCEOqgupEtFOoTc/buhl8LhvF4T5yzcb/w8X66x3c52qiEsvHu6vlCxhbqtJOU76jpmfvKrfKCn3dPO7lVO+9HW2TNEtRJr/9okXddsBKYVc/98yk4RSbLp5PpISkol3f0GBObF6eQh3u5fmf54kH82prVxxMBFl2xoWiUwHAhVI9q24iV1iF4uX6ucw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Sun, 16 Jul
 2023 16:54:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f964:e0e9:199:9246%7]) with mapi id 15.20.6588.031; Sun, 16 Jul 2023
 16:54:59 +0000
Message-ID: <134a5c54-7f2e-9580-3655-2cd7e18c6bd9@siemens.com>
Date: Sun, 16 Jul 2023 18:54:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Releasing 6.1-cip-rt?
Content-Language: en-US
To: Pavel Machek <pavel@denx.de>, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com
References: <ZLO69J9ZmUBl3+cy@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ZLO69J9ZmUBl3+cy@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4014:EE_
X-MS-Office365-Filtering-Correlation-Id: 673ed33e-f719-462f-960d-08db861d63bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jrRD0T/G6JontiKvHkWq8iacBBKFq8j5O1QQR6RDVHlquJ9f/A7g/8ITb9Rwl+AyEAFvCnxzO172RCPwE3a1kaxkDVe8Bf1MgjH/yV1y0NqOuaI9D536fJ3DH/uI1nd8Vv4Eh9rjXVXyS7dR7FqhyA1P5NBrtIeZ+SgHBZ67RseHMgWdxM/sku06lkCF09b/Tu0iGC0LnsMNuW4g6bAsZRe2YxlERBvdeojHY7PG+bGKnlpc27D7D1yvvrCYF9oWj3+KeIKwTO4tzBhymPJDnEhtcqM5VsbE4Foa2/Cq6NeU9oiqNbS567S/AMYddn1YQ7maeCgmbuPbe6nlMwK7kCtcKe+9NCFjUGN2G6Ih+BzO0pw1bSYNhZEqArSl//AdyH5v13ZfJnVXZ35VOYOzroDQvrBaOZeYPPPx4l9v3SrC4EKfhU8cFH125DDKk8MPybkrFjJn1X2JIvhTruYY4DnIzAFWMWmWufuRSmJpSYKNDZ5mwAt0zyj1z4QId2UVKt8fYMrcPWNOWhMBQ5xFG7QpqendymMdp8UUfMzggMjGyRjQ3PEwkCJI6KFmAgKRSYDrizDemnoo/HyzypBRWNJBQfdQpXeY/coaBw3fzo0bZG5CQwDM8VDmX0ZsrhrRJeUYdb29Bd6VfJh7iSAROA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199021)(82960400001)(38100700002)(6486002)(6666004)(478600001)(41300700001)(8676002)(5660300002)(8936002)(316002)(66946007)(66476007)(66556008)(2616005)(186003)(6512007)(966005)(53546011)(6506007)(26005)(86362001)(31696002)(36756003)(44832011)(2906002)(4744005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TndYajNBVlA0NGluWVhBZTJGQ1BKUHdsWlI0VkRKbDJTTXFTVmF5Nnp4cTRF?=
 =?utf-8?B?bTBmcjU4VFJKT2pkb0lWRTNTTU9USEtpdTFlUHhzb3psVGtJSzVQOXdmcGhJ?=
 =?utf-8?B?WEZUV1hwVzlGSTk4eFdRejNXMjI1cmhUeHNPdjc5YXEwb0tXODRtRGZGeEFZ?=
 =?utf-8?B?amIyUnU0NHQ0aitOM3V4b05CMVRUMEJ4YU1rM1Q4TEtveFdDU1Q3cVR2NmRU?=
 =?utf-8?B?RHlMa3FQN2RrTzlyRTZqMjNPK1o2bk5ZelhYTUozaHYzMUpsZkFQSDE2N0FG?=
 =?utf-8?B?UWNyUGVZNHdMdktFMHhvNy8yZnpSbEsrUnRWc1NVZTE2anR1VUJmQ0o1WC9G?=
 =?utf-8?B?YkUzQmNMY3V1Z2M2WCs3Y044dkVvMU8yOGgydE8vdDdOYzE1Vitnazl4cGVj?=
 =?utf-8?B?eDdRYWg4cWk4cHlJWUZGM3Y3aVdVa2xMODR0ZUlPakFHU2Mwb0tSWnhCemVT?=
 =?utf-8?B?RTkwbWp0UU94bnJyL1RzMm1qYzlGWHo5cmdDZjJNUnA4SEFzaWZuQmRxK0Jp?=
 =?utf-8?B?QkR1WVYrRC9iZEVLRnZiQ3BFWXJFUVJTRnBXNTdrejAzUHh6cVgrQTVMYU02?=
 =?utf-8?B?TTB0bXExaTRaa0NJZUhiM3dxcEhobnNYSFkvYy9yOTBpemN5cXk0cHJkUkxC?=
 =?utf-8?B?a3VNTEN1ZlIwMFZFWFdHYUUyNWtHYUhGVU93MWRydGJuTjRrcFQ2Nng3KzIy?=
 =?utf-8?B?UG5CRWJIckV3TTRDaWZZU25vK0crYXhVVUlkc0pxS1ZnTEdjNEVVSFVYZUZN?=
 =?utf-8?B?OHFzN2N5VHovdUVENlE4eXM1VnVTWWh6OVhpc25La0JFRk81cHBUeVZzbXpT?=
 =?utf-8?B?L1JRenJ5TmliR3hBR3BUbFFsWWVFMjBWNEJRRUlOMXZUazQ5UzcwVnYxMVVM?=
 =?utf-8?B?Z2Z0Zi9hc3BYNXRqdHl5ekZDVk1xLzdxNGVLYkFseGcxem84RVBmZ3BWV2Vv?=
 =?utf-8?B?a0ZRYllhbTNCTmFLalpjb2dacThTQU9IVTloWlJzTXIyS2lMWjVtQVEyVmFv?=
 =?utf-8?B?cDl4RUFvN3hKU3RaRnhLVmZmU3dRczIrbzg1ck5JU29pa3ZDREMwNnVFejEw?=
 =?utf-8?B?dTN6SmFEd3I5OHhQZlpkSWwyNnQ1aXJqZkx6RG54dExoVE9mbWtCT3ZOMzZ0?=
 =?utf-8?B?c1V4c1BJeEN1ZVI5enY0Sm9sZlZWMEM0Vjh4SkFuakZrS0M5MEd1dFpmU3JX?=
 =?utf-8?B?ZXV4Q3VXUjRhK1JFNE9KY25QOHB6TE1ncERuc3FMM0sydG9EOWxjaU15azk1?=
 =?utf-8?B?bVNqOE9LQUZhbjNycTJ0d3FFdGFFaTE4Y3AvY0hSdThNaFZJZy96eUpJeG8r?=
 =?utf-8?B?N2VmM0s4YXNyNXpJejVweWpXRE9RdFR6UURURkFaVWV6TG1iQkJtTDhKaXpo?=
 =?utf-8?B?VEpqL2Z3K0JNV3dTL2NjRzNMbzdISGVwakZLSTRwQkhsdFoweU9oUWptOTRR?=
 =?utf-8?B?QjZLTWd0dEpFQ3pqQjlsYVBQaUlXQ0ZKd1NyOWh5NzFVandvaVhiZHBhZWFP?=
 =?utf-8?B?UUFEQ2d0OTE4U08yeU9lNmgwdkhGQ1ptc05NVUcvN1lEZTZ3dno2eWRodnR4?=
 =?utf-8?B?aFdaTjFBQ2QzM202ZDJpVUh4TFVNVHhMc0Fha21nVk9sbkF4NHRWVzVqV2Vk?=
 =?utf-8?B?eGlGUDRoSTY2ZTVyUFJ5aWpMYVIySFpHQ1FpanhaZDRLQ3ZJTXRRMzBnaHBD?=
 =?utf-8?B?anpkUFhqMUt2MjFybFJRZjJRSm83WExBNHR1dWVqeldkYlNQSW5WeHJMWVll?=
 =?utf-8?B?OXBhYitLajd0NDJ0NjdrdmpITU13QUlQOHpHSWFxY0tVSnRwRmc1QkF6ZDZa?=
 =?utf-8?B?ekYrUU5FNzBVQUxCTnB0UWtqZmRMQ0oxaE1HblQ3Q0VHa3l0aG5qTm5LMCtj?=
 =?utf-8?B?eis4aEdzU2hvdUM0WTV4MlVtWi9zV3NKM283N05XVDdrclhSbDJmQlJiUllz?=
 =?utf-8?B?WTdvalcyYzZROUFiZDI0amtBUngyTC9LVHRjZ2pDU1kyaE1XcGF1ejlHY3FN?=
 =?utf-8?B?dXZVL2pPQUsvSnpQbm9qZWFvYXdYYjltdXZxZkoxcmxvWXFBdUJPZ0QvL2RX?=
 =?utf-8?B?ZlBoWXkrUXU2NGJyMWJXeXNOazBvd3JCaWRxbnZQZVhHMEh5NEhBTHhUN1lW?=
 =?utf-8?Q?PSd0ZISNDALqTxwbOw+Gr2BnE?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 673ed33e-f719-462f-960d-08db861d63bf
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2023 16:54:59.0473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYs/JEGto++fr9dwQ/2OhfuXv4E6ICfHNgN+346WWjBt8QeOd7cTbIlHEU8A9qGtoIr5MX+QlJpASGV7LoU6dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4014
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 16 Jul 2023 16:55:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12362

On 16.07.23 11:40, Pavel Machek wrote:
> Hi!
> 
> I prepared simple merge of 6.1.38-cip1 with 6.1.38-rtrt12, and seems
> to pass basic testing.

Do we have "advanced" testing as well, or what do you mean with "basic"?

> 
> https://gitlab.com/cip-project/cip-kernel/linux-cip/tree/ci/pavel/linux-test
> 
> If there are reasons not to release this, or extra steps that should
> be taken here, let me know.

It should be tested as any other RT release, otherwise I see no reason
to delay this.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


