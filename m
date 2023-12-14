Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF41EC4332F
	for <webhook@archiver.kernel.org>; Thu, 14 Dec 2023 08:13:26 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.87])
 by mx.groups.io with SMTP id smtpd.web10.17381.1702541602964798628
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Dec 2023 00:13:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=UhvhP92h;
 spf=pass (domain: siemens.com, ip: 40.107.15.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYMhVb+EGPQiXgZGafTdkFCMVUFacJR2ZYt2snCM7QLaoigAg2YmyrdtmXjmaW9XTlGWGN2DKYmLhaAc68nhouU+9zJwucBT6SPJ1CMd67AK8yFZa9whxcNGYLwozD0zXbqmtnIvYcMqHvNTNQvGlfa6xjJdSZhOikQx9j85bIB0AGyi/xa2yrYNS2erIVoKEjuQl40UjSLgckXgCWLKmsf2FFW0D8fiosUpfbQgMwDgX5AXVbRf8C2jXKnqNxm4Dpxro9Nfzdh8UCyOXKNPFOhxjC3PHb7yGgr1ObYdRmIytoqrNG7egYh5snQ0Sfnpwodma7KwXWbjryMQMPnPGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jtGhj5jwLAFLbvNI2F2DXWLFSu07Dk/Dc493wPSNOh4=;
 b=bMEaSzlnHv3GcH7JGn44RfX5JaiDUHEDw6h8lw08k4FvrcSpNXXmJqwOa4RtfZhpV9rsIglQi6mM4W1TVmZmPMljTJBc7aGVQrQMFUdRKOW/AVYSHKvuR+f+i+lF9sbWTR7xKtXx2BVZRfztXx8EObiJP0JYMPrLbQBQsIupAicXQdfGit2IUbmqra2As1sWPAc9HeMA9+x+5Jzogo1E0RQXR+UDZ1TJDDuZx7QWERU/duAbXfvKjPtrlxw20ouyLWh+YJfE5mekKXalq3th7M61zAc9NSI5bQ9scnrS+tf/yz3ac32cm4RvQ6FBsLHKqQ56E6SQn473xJsgB4QubQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jtGhj5jwLAFLbvNI2F2DXWLFSu07Dk/Dc493wPSNOh4=;
 b=UhvhP92hK6LY4q6Qky8wG9ayclGZqGA0/L0roXu+UV62SNoRjHzb9CmrXXFaeY3qjAqDKIHby23ZmkBSc2IYWQBo1IQgz5Xh3cK5cWNdimDKc4HyQcDzUJJWLW+Q4/1mubDCZDrYVMAgdGtL9MsLvDQnNfZLNEJWrn+pSC9Z64f0kSA6dChO8bAM4egAQtVWP4bgYJv3tieuu5IR5KrbBM1aL/sS12Me+Oe2ipfZ9i1O6u358rPuuaT55PdnPSGMstWWOkOETLDvRtFW+01dedNFVKP3V/0HgSyAl2+epwHIB6leZfJSvJH38hkbos5VUNNdAXNOtWY9IWeghgL+1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU0PR10MB6875.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:464::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Thu, 14 Dec
 2023 08:13:19 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a40c:1061:b15e:cbde%5]) with mapi id 15.20.7068.033; Thu, 14 Dec 2023
 08:13:19 +0000
Message-ID: <9a8b081c-7435-4e2f-890f-400153aab1c6@siemens.com>
Date: Thu, 14 Dec 2023 09:13:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 0/3] Add Bootloader to Update
 binary
Content-Language: en-US
To: "MOESSBAUER, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <c128e4def13fc0a707f627e5bb8c01cd8bdea42f.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <c128e4def13fc0a707f627e5bb8c01cd8bdea42f.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::20) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU0PR10MB6875:EE_
X-MS-Office365-Filtering-Correlation-Id: 34587a67-60d4-4c59-91a7-08dbfc7c8850
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hb7PZ5TC2zo2jMJs3ZoscFRPps9xMLnQDsrTGQYl/1ZjllgUXlsWkTXq2lBXelIwsh6GL/of0RJ25CoWG56En3fxecRaPZnmMyMgtG3eFSEejeFgD4ceT3g65Z1LPIh13qhi6Zv/glGV+G+uyM+1gFimxfrlaZCJ93GlLfg3Db3J1Kq69CY7Ref1Nr388le8u1Q0DfVoQEl+dPmHIXvtFaZvGzDHU9CAp4JTUZMNKW6quBZdB0yyGPTU4OuZ1vrZ6TgimFMCvXy6kTotKMvtcpOQnQEg/R3cKtG1O8NmgTA01NgOqwsQc0z7hrQdHK0K/cL4w5sfRNB2sn7EDihUy89bnFt/B5Pskqb6y1pfFcwvGxPotd9mcKzLCTc7NOrX2UzPO3ce9uZpV55i5A6gFxa6erbpbWx+NooFe7Mwn5Vd0jVTFSBquROcgOu1s8YDDgWYn5cRbKs/+5wNygX5/hL3d5RB72yXR1su3LwqoFrMNg5pGhRazU/QT+nUIR1Ha0GZd9EUYfVoVQCfKVJ5QAI4fcH5KggwU+LWmjoRt64CRgj0p/Z+VKa9Vwp3UblEtnIfvTevIGaZ1bCWCF914ubLaHOSjfGG4otf5E0QN29gOnvxyCWZtayTSeECh4iOEz9GNdbd01AiI/f5c5AAVg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(44832011)(15650500001)(2906002)(4001150100001)(5660300002)(4744005)(478600001)(82960400001)(53546011)(38100700002)(86362001)(31696002)(36756003)(6486002)(83380400001)(6512007)(2616005)(26005)(6506007)(316002)(6636002)(41300700001)(8936002)(8676002)(66946007)(66476007)(110136005)(66556008)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cmtjZFJDV3RuTEYvZjlLdFRtYitVN2ptMnI0RmVlQVoxcjVPK1ErbVpLcVR2?=
 =?utf-8?B?dDljaHF6cXdzQTYxd2NvYzFaWFJLam1Bc3NSeVY0UU92cXU1bngzUDZLd0Mw?=
 =?utf-8?B?MjFRd2M4cGtIckVSWGdocTFlN1h1MnM1cGZjU3EwcEdlZzdjc3dueDNVSmxx?=
 =?utf-8?B?RzBQcHpTQ2RscEF1L2xPeWVzNVFBamhlUTQ1Z0p0S0VCT1E5T005bEZuTXJL?=
 =?utf-8?B?c0NBVGJHdmFONGd2SzVpWndKbEdxMjIrUjJFU2lCL1F2ZVlRNHBnVG13NXRS?=
 =?utf-8?B?bjluUzdEc243VTl1Q0JNaHF2QWxMVHNaSE5oQzZhOVlDNGMzSTZGaUp3RzBq?=
 =?utf-8?B?bVpFTUdFL2s3eVRMODZ6RDBuT1RlNFQ3dFVKZk5LSDZWZzgvT0Z1ekNuSnBw?=
 =?utf-8?B?T0JBMVc1SUdxV0tQVUxHTlVoc3BHMVJYYzdTWXVVK1pPd1lDcHpuR2pqZUNu?=
 =?utf-8?B?cjJBQzlNeUJQRldFL1hoWUxNWFlCM0VhSXYrRW01Nm5hN2JZbnRULzhxSm1h?=
 =?utf-8?B?aElkcGQ2c1Jkc3Z1a0JGVXVVY0Yrd05zbFBYeUl4TVpVcy9YbEc4K1c2Qjcv?=
 =?utf-8?B?QWt4b3lZcXpMTUpXeHpsUjFGT2tMUmgxTTFONlRYckFycW92Y3JDNHM0N0k1?=
 =?utf-8?B?T0U0SzJ2OGt4WHpsK3VzbVBBcFdMU2E3Um1LRjZ3L2Zjc0dUYzA0K2p1YUoy?=
 =?utf-8?B?d0x0b2taTnZWTVZadEpVQnhuU0hEV0JMUnRPY2Izb3dMaWI5SEd2V2hmQTdI?=
 =?utf-8?B?Z2ljYUd5d3FvVFU2ZmRPNGFmVm5peE5LT1Y3MHRhaXVEUVVRUk51YWtGbWda?=
 =?utf-8?B?aTc4Q2hsUkU5OC95SlZjd1E1YkRpMHlRZVhUN2U1bklMaWsramhkeHI3emFB?=
 =?utf-8?B?VDRIQnVMSXJKQUJDQXVCdGQ4U3RYU2lzeHFkQk1YNk1CQ1lqOVl1S1U2N09h?=
 =?utf-8?B?M3VsdlhZQlhsektnR3JHSmpzam1OWmZuTkJJSmI0aFlOcWtIaEkzakVnMTRv?=
 =?utf-8?B?ZUdCTGd4WE9TaHVjSVJWTjdYYTUwOHAyMXJYWUpqbGpTOUhxUS9KWStiSzNQ?=
 =?utf-8?B?cEhBcFFGR0E2Ry9NZ3BXVkE5T28reGxha1VOMjNMa2VONlJxNXBZMUk5Skpv?=
 =?utf-8?B?SUwraDZDN1VNTFI1S1pVTlA1YzRyNmxRMWdqNGhqK3hRUUdWUjZhcU1OczdU?=
 =?utf-8?B?YkYxeVIwSzFVWHg0Q0ZmWWNQQURXNS82NTB5YkhtNlVyV01yN1BQaU9GUGFi?=
 =?utf-8?B?U1RyWVJ0bENaaUFYbWRzNkI5Sk42K0k0Sko4NjhDKzhyOGtXWXdvQVdsWHda?=
 =?utf-8?B?SXdRaFc1MXdScXVQOEVVYnlPTU9kclRCVVJ0RWpNRzdpNzlQVngwVDZQYVdi?=
 =?utf-8?B?alBYNVdjVTEvWEtncWFIbklqZmdRaXdQV2lZVW9mdGZLMFg4QWNUbmgxUEFC?=
 =?utf-8?B?Y1oxZGpHa2VheWdXNmp4RlBQaFVKc2JQUXRyUTdPeERDMlhJMEdxMURVSjNi?=
 =?utf-8?B?TFF0S1BNWHB1SVdST1B3alhlbjZ0U1h0QVlCdUo2S0RwY0NNV0UrOGJaR0tR?=
 =?utf-8?B?b3lBUFN3L0hCVXB3YVFoWlZoSTVmZnZVVE9Kc0taTnBVbFM1a1BYVTQ2cms1?=
 =?utf-8?B?WlV2Tm8xRTBVd2w0eUhsUy84eWFzZGNZYmI2bExUMFhEV25EdFVkZlpuOEhB?=
 =?utf-8?B?VURPZHgrNVBDcTN5c0RZUWZINlpraFovS01GS1djcWREVmV1KzUxSXRQQWY1?=
 =?utf-8?B?THd0QzduUnh3dDRMVm1jR2MzT05UdXFoOVI2OGpaRVIxcklNZTNnVGlGb3J0?=
 =?utf-8?B?T2dRQ2VJWVFhalhkSnV6TEJMR3M2Y2VNbVhsSTJGWTFOMWFuUm9mNUpmelUz?=
 =?utf-8?B?TjljUGVCbHlya1JXdGFSVWxHU21IMTl3R05TdzgwZjNtbmdPb3lCdnNNZ09R?=
 =?utf-8?B?QkRpbkNldU1UVW9hdWpheEc5RUJ0ZWZRQ25rVk4vbjNwaURwSW15OWhVOFEz?=
 =?utf-8?B?VDR2SjViamtsTk9hbW5GSjFEMnhNcXdlVTlub0Q1dURQQUJGZGh1dDlCN3Uy?=
 =?utf-8?B?cWJWby8rTVY3QlpqVFpiaUVkWjdDeVdqb0FhL1lCT3JYeDJoUXNEVGg5dWxU?=
 =?utf-8?B?emRBbDJMZTI0Y0hpNDQzTWpTVzdhbW9CTklrLzQ0SnZ1OVVQNjFRRXZQaEts?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34587a67-60d4-4c59-91a7-08dbfc7c8850
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 08:13:19.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyi7zfv01+5pTgl2LM4vvTS4hoRyWisUtbjo94UqKPfjKl4q2bDI4jmve8Ll0HKbMECjzu3x6FUCA98lfK9lZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6875
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Dec 2023 08:13:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14090

On 12.12.23 09:20, MOESSBAUER, Felix (T CED INW-CN) wrote:
> On Mon, 2023-12-11 at 13:19 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This series adds the, possible signed, efibootguard binaries to the
>> deploy dir
>> and adds them to swu file and sw-description to update the
>> bootloader.
> 
> Hi Quirin,
> 
> I just tested this series on a nanopi-neo-core (armhf target) and can
> confirm that swupdate successfully updated the EBG.
> 
> Tested-by: Felix Moessbauer <felix.moessbauer@siemens.com>
> 

Quirin, is your plan to do the further refactoring we discussed
personally on top or as v3 of this series?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


