Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A971DC46467
	for <webhook@archiver.kernel.org>; Mon, 16 Jan 2023 12:22:57 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.44])
 by mx.groups.io with SMTP id smtpd.web11.165093.1673871774820824302
 for <cip-dev@lists.cip-project.org>;
 Mon, 16 Jan 2023 04:22:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=AL7K3F4C;
 spf=pass (domain: siemens.com, ip: 40.107.104.44, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIdRGleMUBbSTFqQ40JHu3BLdQSRmOZIhccxTkdIHW4Po0uvgOdjGzcYDlAiV8AekWn/MjT7VHQpeCkziGxbwiWGLLWZi4Qsc0yNNcmJ6IZzo9bkJEcK7hJ/za8LAjuww/Xm7oezRts/LFEVFMq29X/AMG9H/SBz7eL48VrrtHYX2BmMIqQU34EbHJZk7vZYFB4ZTV0uO3UVN/HUk7GzUZzc+sZzCr5uYNnT9gaSDGj2pRet2NzsWIstDmfOBo7MOaduynP9Jn37m2aX7J1WuSffiBkl5Qbp3bRrzDLtBTm6TcpZaZqmkFZpNJauHnUqHl7VQSyMZkleM3Pnlt99wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lTJjgZivvNhY/a4OSeKGsKgAKfqTO4XSz2eVZZBlLc=;
 b=kg8doEQAuRU9dFduWsqFNEGcZuAuA62a0cQ1LFPT7T/91Dtc5X85+CR/u6+dcjqgCg6jsVZsSGEpCRwwnjQbXW/NjwWJiGslpplepuV9tJQk1jffcpaA8ff74DZ2EqVGgWlCbA8M57FXo/BH5LGtwfo8RS/IMp02OZLjlbT8eh7V44lYj33aYgWQIQib16gLKVz2AzeFxJ3ju10ikR/c8AvuwxggDbOJnAdFnFZVRuyN5q6FKjdLX87zdbFyzHmSAjlRWxJY5RzXt1LvjqVVWqWRRw3iNh8jyIgJTtqqXMOVoevRVbfDWYBK/K+tbItZdbwu+lJJWM08twQins3Dow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lTJjgZivvNhY/a4OSeKGsKgAKfqTO4XSz2eVZZBlLc=;
 b=AL7K3F4CGy+/U28cQo6CF6weX1ctcXPYeYowFsL5Rp28hBwbwVarGk/iyRLKRctyZqzI3hL1eIzm+oqoZuFO4L1f9xikCi3oYe7LnZ9j5UUp0JXqAdr7jUL9hKxH+8hdIvXe0wl3j3cminQTGAKD8lXHsj5h2WB/HmIkCmv9nzlQc0bhd1igq2MPufBNLS2M2zEOlHbDYnu/0SU5QT+2Dol3fyDiX4PkPjKmdOG3O86uYW//SIe9DfHobS4BQeBdpuUUSKzKdQM+AD6tuGpC80E978W5Pkbugo9067TPyGUQMOQK1rqJCeiK1AxHBv/miS439MzaiYwsOc+0pH5Q8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6742.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.13; Mon, 16 Jan
 2023 12:22:51 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%7]) with mapi id 15.20.5986.019; Mon, 16 Jan 2023
 12:22:51 +0000
Message-ID: <4afde947-2482-5c4b-6eca-ccd282b693c7@siemens.com>
Date: Mon, 16 Jan 2023 13:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: RE: [cip-dev] 6.1 LTS
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <c4648640-e690-5afb-85fc-85bb81889737@siemens.com>
 <Y8QvRNxsp0N3Sa2D@duo.ucw.cz>
 <TYCPR01MB105886142D52E992A8E3AC6A6B7C19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TYCPR01MB105886142D52E992A8E3AC6A6B7C19@TYCPR01MB10588.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::23) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6742:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5a0d4d-db98-4891-2393-08daf7bc62fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sJojTeHzII5LxnRtjl4yDYzhjAmnfDZBdMjKeBUoScNdS8lCaw9SS4sL8dDHrfs1OwqdWvKz2ESLkV+ZSRvbF3lguydRPWPQ+776ACqcA+8MjLkWJugbxkeadlQ7JASbmueF3yhqGPRH85YpCSpMmZnp9Oz0o8ME1Ni182L63T92MbsOa2SLHGTzNgdhl1g3iWqswM9CLuJjAReZcI/whU6exeoDRzQ94QrgHMbpUYN5pCYk5cofOkaAzjp/w+AcrQxfrp5Wmoc60QlRVce1VbuA0Oj9SY82CW1jzJnFd7uah2mFd5htVM2WnYAm8L3lGipetXn3ObK+Q5k1jcnAdUDNX5t0vxUNe0cASg/pVH4seyEXd+r8JF3UYff+Jyxn1Vz74LmWj1FL+UeAfJzQwCcD5lAM4KFRO6sPiY7lV5bEQoyPmv4/zrXZVNvCVJ8kVnGo1Ix6N50QvBO0wbTpnGgFJpUy6Em4d3Pi4L7hWKtCoY0GWo4Q+9n/1wpYdXxOx1J4J+yWvHBcnLG+gmqVvIrBXEz1su/XAA1fXh3W8RQ2F38ycOhMdQ1MHggUC6e6ywbcTUAu9tjTo0Bq7AykoDRfadtiPyaG7zmGAsqnyto1rL10nYndJSArDRfm/wgygwIUuBDyyRzVYQp7+4NGIXyNmiFAh7swNOQtOxD1m6+f62O24uG6NljpUlHIi1CQBfYBJ9S9EIiAWUuha2YNADmtCQsFR2ucky4+rRgFMJxkqQZR3Z+CwRyjiFuJR8jjdir88andpphZC9+36nEalQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(366004)(39860400002)(376002)(451199015)(6506007)(36756003)(6666004)(2906002)(53546011)(5660300002)(8676002)(8936002)(44832011)(31686004)(38100700002)(6512007)(6486002)(82960400001)(41300700001)(966005)(478600001)(186003)(66556008)(66476007)(26005)(66946007)(86362001)(31696002)(2616005)(316002)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?anlPRDJFQi9lZ01tb1VmcWpqU0d5T1hHV3BlUllZa1ZhaUJTWkNLcVJESjFv?=
 =?utf-8?B?Ym5NdkhZcjJ1OExub1FUWHA2bENKOCtySEJuNW91cEtkbnRHcUlQNGJ2MzUz?=
 =?utf-8?B?UFZZUy9Wakd1THZoR3FidjAyRWt6L012N0Q3eUIxVFpMWUxXS092d2IrYzR5?=
 =?utf-8?B?MnFXdWs3VlJGbXdYalVPa1h2RUI3eFN5aTBHVVJYS2xUZlR1Qk9NZExYcVc0?=
 =?utf-8?B?ZHNJbW5BcnpvT01VcjIvN1hFRVl5N0w4YzNXbDV5NnZjeVkvd2JVMWx3dStM?=
 =?utf-8?B?WDdicmI0Vjl4VmYwdzFDYm05WmJMdm1TWkZUZy82SDNDb2dJYlRRa0xpTjNw?=
 =?utf-8?B?MUxEamVkVitWc2JHTWtuMGZyVmY1NzBJVmJvczgvM3MrU2RBUXVpbzFXVHg1?=
 =?utf-8?B?ZzVlOUNPODdHUHZvT0F6TEgrS1VHczAzSWIwdk85NWFhRGprWGpBbVJncm5V?=
 =?utf-8?B?dWpuZGtwWTVUa0JWVXVrZ20vL013UmNtVHIvdW5ITnFUd3lZTE94M2dndHVs?=
 =?utf-8?B?V0gwbExBcXV3WlRWaTBKL3RqSmNEUmhydGMwUEJhV01XZE9hallrL3ZTdVVj?=
 =?utf-8?B?ZUR6Qy9HUE1ER0dibEVIcVRONHZMQnhGVmpQdytWM1dqVGQzYjAydEt4dGVJ?=
 =?utf-8?B?Zm1RVXNGT0hReDBRSFFISVpQcHY4aTRqSW1UTE1PaTl4Vy9ybi85eVB5Z2tq?=
 =?utf-8?B?M00yZ1VPb25ySVNFU1lUV0VzVXZCSFltRC84YkpWWHQxUlJFSExvbDkzOWtF?=
 =?utf-8?B?VEI2cFJrVXNodDV6VEE1dHVsL0x6ZVVaTGFFVzEzb284eTYwdE1oZUpaQnBr?=
 =?utf-8?B?T1RVb01keVNpbGxsb3ZMbWV3NjNCWTVMSjZNZmJaVEU3Y1dnS2ZsbkhCdXJw?=
 =?utf-8?B?eEQwVzBHQ1NtMU9ZU051UDJMSVRvUVpHa3k0WWFPL3ZmckxCLzN6RzZ0ZkQw?=
 =?utf-8?B?L3crOHhKa1BqUnN6SVlTTkI0ODY4akxuYUIyYm8rSjd1MmNYWFdRNE1abWs4?=
 =?utf-8?B?eU9CMzJnVDFTMnBHY242eWltaU1zVjVaclphYUpnRDBicWRyYUZtSjhmTjBZ?=
 =?utf-8?B?WHRQU1l3M016VXY0VlljOUh2VVlYK3B5NzMwVE5DUW1hMnpOeHlNOEwxWlJR?=
 =?utf-8?B?Vk9JNU1FM3lKc2hlQWxaQWYvS045MDVxOTVpNFN6WlNycmFlVW5YbjQ2cnNy?=
 =?utf-8?B?R01yMkdYRnVDN20vSHJwN2tyVW1yMnpjaUFvZHNER3BNeStIVk1wYXgrYWJO?=
 =?utf-8?B?MUY2QXhiZjEwai9zYldWVkdpelIzSERGd3FBaTV6SFZYVFBGcWhHN2pmd1hj?=
 =?utf-8?B?VnU1ZU9HT0JwVENhNlFqVnFXT20zUG1PL2Y4UUVkUCtSRHIzMGNHM3ZFS0NY?=
 =?utf-8?B?TFlFVk40cWRaOXNld0F6SGJZUnhKMldqQVpRMi9qZXhMYUVqVVlnaUdkcjQx?=
 =?utf-8?B?eW5IM2tYVzNtSW5Sb0pFUFVtZldOOUVrZWs4WCt2MXJTdGNjTmF1ZC9jRUpS?=
 =?utf-8?B?eVZjSi90NkRWRU1iNWtuN2xsVHRlcG1PSHBhSm5lWW5pWER5OWI3OU4yMjlz?=
 =?utf-8?B?M3gyYTZvQlI1cDdialVZUFpJcEdkS3lxYzEvOVRDWDNRZjFRcXhPL09YMlVR?=
 =?utf-8?B?ZmJmVjlxU2FWZFlwUENwdTY2WXI1Qk5pOVNidTV2dWV0K0REdFBmM1pQakxl?=
 =?utf-8?B?dy9KVVU3UlBrek8zdGxQcFlOQTJzYTZIdmptQ2diRlRZQ1cvWWRLNnFVR2xs?=
 =?utf-8?B?UEVkNnFJbzJlU0k4YVVsb08rZWhQSHVRK1lOME05emFuam9mZTRGL0tHZ2px?=
 =?utf-8?B?SlBWQ2hmR0t5YnhlRUo4T2U4N0ljNUIvaUZDZTRrY3NpOWlqRkx3eUNadVRV?=
 =?utf-8?B?WEN2WHA4SWxxOWdjOEtZaEk4VTErcCtsa2ZFS1BGTkJSeTdQbzRNVTdxSmN1?=
 =?utf-8?B?bGVNMGQwaUhpMGoxYTdGVDB1UWlTNFJmTnM1dk1Obm14bFN3c2pmd0VPclVq?=
 =?utf-8?B?VVFHdXlEVjlMNGVvWURRc1lWN2ZHYXNaM2RRUUhzYlEzc09Od1ovdzZZeEl2?=
 =?utf-8?B?Y2ZJZFBOTThGbmJkZHJ2VWZLbWdYQWc3MkVQbURneGdxMU9zWTBhVVJTa2I0?=
 =?utf-8?B?bkxZamlKT2hkZWk2d01KYnNPeDhuRmJUbjQwazlpNHRDRDY4aEZsQTlnNkJP?=
 =?utf-8?B?Mmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5a0d4d-db98-4891-2393-08daf7bc62fb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2023 12:22:51.6790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NnQwVaF7OAZuicOcfOFxkAEPSzPHhqWj58qzkOM0AaEl6ldP1fpq3NKNP13t05sBloMoc6BgSmstRs1vaRS2dQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6742
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 16 Jan 2023 12:22:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10371

On 16.01.23 11:46, Chris Paterson wrote:
> Hello,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Pavel Machek via lists.cip-project.org
>> Sent: 15 January 2023 16:52
>>
>> Hi!
>>
>>> in case you didn't see this yet (thanks to Florian for pointing it out):
>>>
>> https://lore.k
>> ernel.org%2Fall%2FY53BputYK%2B3djDME%40kroah.com%2F&data=05%7C0
>> 1%7Cchris.paterson2%40renesas.com%7C3107d6089d4c46d7ad4408daf718e5
>> bb%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638093983549460
>> 193%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2lu
>> MzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=Mf2BG
>> 64zLwKGm6Etz%2FdQGZjcrZEDOCVtB8brOGZ5h5U%3D&reserved=0
>>>
>>> How could we contribute to this as CIP?
>>
>> Well, I believe we should start testing 6.1.X.
> 
> Agreed.
> 
>>
>> Greg does not (and can not) know how well 6.1.X works, and it is hard
>> for him to call if it LTS if he's not confident with it, and that's a
>> place where we can help.
>>
>> If we wanted to push it a bit more, at some point we may want to write
>> "hey this seems to work okay for our uses, and we'd like to see it as
>> LTS" or something like that.
>>
>> On a related note, 4.9.X was discontinued; I believe we should create
>> configs for 4.14 and start testing that, to help with 4.4-st
>> maintainance.
> 
> Is there a reason not to test the release candidates for all stable kernel versions?
> (Currently we only test LTS)
> 
> Our CI will be fine with the extra workload.
> It would just be a case of someone checking the results and feeding it back to the stable mailing list.
> 

Would we add value this way over existing kernel-ci runs - or don't they
exist?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


