Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30DCE8349
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 13:54:52 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.51])
 by mx.groups.io with SMTP id smtpd.web10.55010.1727704481372544307
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Sep 2024 06:54:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WCtvgzXd;
 spf=pass (domain: siemens.com, ip: 40.107.249.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A356I5eg11AwqfEfm3wgcFfx5Ff4dbG4N/979SOFQ9ybSlXQ8wwN6u+ITzPhg0ME4Dlkz2lJWkx2/qcYtpa/L6WOqdjh3LufaxRBcDy+4e3WpfCGqpls2Q1TQzT2vPWSzmo+lrW4KP4HI0CUl7KCqzNNKZ2C7dwGGNHxtoQIyZpg8814wvJ4D6LFnG3zOicTjOPJagHS3D8lGt/eMUT6qeAJ581O/o3SH9gaagnsoA4uwjauAinICeq1b45w9iRX1MYN03f+fty4AFd599nhV1gLnRVhUbA3FDbHSHJBIvlf4qNqx5nJo9uUUkaOuIyPv/1jwpTcxida8Q1QhmdaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQWq00w/nPW5mvrm1oN7nl46kFilv/Td+I8o6DiwVrM=;
 b=brh4YxKXlPK60TQbG3VD+hw5D2sMh0ZQhH5Vmm5u66BFAsSrmipyf9rsCvdj/gbGSiH67HTSkkc0jCFFwHz1R1fek0tpBvna4LWRSU9R+QQmtblhsNX2Uyf7NYqVb9G7qYbjJPxPKwaKZmF3P1uPV5BVqAWoNnfUM7zvNovEzyT815lIPP0HFS2ioCRGxnyzBShOqLxMYQ8DUJih3RwTdo3gZkekL2zDQHK/3KaXdecVaG8FVPIz843KXjrvxgQI+XWDNVxMCJFOhQNX+dqrdUbsP61EQCIsTSIbV7Hm97nNM02SWEuFfsQKwTWq0zaKZyqeDyrxW/YIEIwnZQpROA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQWq00w/nPW5mvrm1oN7nl46kFilv/Td+I8o6DiwVrM=;
 b=WCtvgzXd0pvmwmFF/UUXQRG5WnC0CS6jV1tNVDGb8C+nMQbWIqMjbJRKIrsX7QI8DDPMSFkBSMTYBHF30r8w06WrQl/hxE0Fyaqe95CZWZbmxkdoYaiGtfPIy8y9qxu+1I1lXJn5OJ8gOzA1YRjtiNvev3q2D54vDMs9Jhorl5TIFTEIIg0EqjFaxZTx2gJmM12qq8bdfOwRIXSnex/7KD0eDJHjWFrT235LVU98ApXww1LThLAD+F15JpCj/Qa6YDysAdyjagaXh1ZyFJi5/0Ij5mpu27xZqFuJaYsJeI3SM3toR4eC5o1Ym+7cVKjsL1evjpav09cWq/Zz2Q6M3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PAWPR10MB7747.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:366::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 13:54:38 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%5]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 13:54:38 +0000
Message-ID: <a904facc-413f-41a7-96ad-30c882553f11@siemens.com>
Date: Mon, 30 Sep 2024 15:54:35 +0200
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: Heading for isar-cip-core 1.5
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0058.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::19) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PAWPR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: c9219ed5-392a-4b89-8488-08dce1576c80
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZEZrS2JiWmZXMlh4TzliWS9HajBqUVVQUUF6djlMdm5qR3Zjdk5GYUp4TS9G?=
 =?utf-8?B?OVF1VUE5eXozTFJEWDRxaUJDZk8xWHcyN3lUNzZqaFFlQTdGZytOYXArSW1a?=
 =?utf-8?B?NUxwUnN4QUF1ZHF3ZWNsWlpnSytJVjFxSjQvcFdJSVdwSGxwcm96T3pJN0My?=
 =?utf-8?B?VFFlVHh6T2k2VlhmcExpdDRpSTlXb3JLQVVMQysrWHhyaURXVk1zTTB6elFi?=
 =?utf-8?B?UCtjdFZhdk1Cb0dTMlhzanNJWVRma090NU96UVZEU3ZTWnI3aHp4RTZIV3ZO?=
 =?utf-8?B?clZYNkVCbXVzalZoWFhlZVdRZjAyR1M3MG15WjVaY2R3TVlFYVV2ZnhqSDdE?=
 =?utf-8?B?d29JZnVlKzVxc21RbFQ3UXU5M1N6ZFpPeDVlODRxczMyejdqa1poREMzWHdK?=
 =?utf-8?B?TXFUc2N4YXRhMUxtUVZPNCtLaHkrUUFzUDg1dWRJeXlLdGdXZlFLaHlZOHlh?=
 =?utf-8?B?QnVmSG04dHRvdng0SFNPOHUwZlBRUVlvSnp5dXZRemRWOFJnL0NrVnA3OTBr?=
 =?utf-8?B?V2xwODVpL0QyV2FSL3pyOTBKeUdZT21nYlNRTkdqdTRNcStrOEwvdTMrTEdm?=
 =?utf-8?B?OElNTmx6MElvYStoM3lNclliRzY2UnNkYURSMkZ1NHN3WC9IaS9PNUV0aVV1?=
 =?utf-8?B?alBCNlB5TFRHWFM2RDd2YjJIeTUyOWl1OGNUYzNjUUpuNXRTbStaNVZ1dXJj?=
 =?utf-8?B?Nk5GL0tvZndnak1yczB5dkVqM01zbDlmdHA5Rkg1U3cySFBEMm1oN1g4dE5w?=
 =?utf-8?B?cTR5bUdZRkU2ZFVLQnlJUlNaeng1aE5oN3BwU2JHdnNldStrNTRsSWFJOGtZ?=
 =?utf-8?B?MjJsMEpNOVgxYUkyRFBGZUs2Z2g2Z0ZqVHNHV05CdFZqTi9SbHJYUHNKQktr?=
 =?utf-8?B?NDMyZ2FtL3c1WFdhR29rVGMvR0kwV2pBaFRPbXBRUXh3WkVJWFlZTUZjaUJh?=
 =?utf-8?B?alYycGJSNEhWeVFJN0oxZ0dCaHNnazhiVjNVU25VRDUvcmpPSk1qRUVQLzRa?=
 =?utf-8?B?dmVQL1dOQUY0aFFTYU82eGFISTVVYWpENE9aalBXYVJUb2k5WENQbCtkY21H?=
 =?utf-8?B?aDBtZWFsMm9HREJPTjFkTWFSeTMrbW5Tc1dkWm1ldXNBbDNHQkc4QzRmQW82?=
 =?utf-8?B?dFBHR0JxczNTVmhxcjlNNEVFSzhSM29sVzdJNnRveEVqUEQ3VXpqQlJiM2F3?=
 =?utf-8?B?UXRORVlMdVp6STM1aHE4eGowWmkvclBGTEwyUDBRamFpS3RDU05CTHB4eUdY?=
 =?utf-8?B?NEptbWpseEYrQ3MyQkk2R2VZT25XaXQyTXRJcFBEWlFEWjQ3MStUaGhDalFE?=
 =?utf-8?B?OUluL0JZYVd0d04reXZsMHVVY0dCVVFRd0pHN213QThxY3hzODJLdEJPQWph?=
 =?utf-8?B?dXp4NEpqamZQQkl1SUxVWnVvbDVCNWFaQTRSRmJBR2hhZkdWdFBObzQydVZ2?=
 =?utf-8?B?eCt2NGtFTHhOWFhXSEdPc2FqYVlCcm8zY00yb01CT2ZTSDNpODhpc3lUSzFp?=
 =?utf-8?B?eG1zck8xRi83UUt4eCtuSXA3ZmpCdlJEZVVYMEFoSm9mNXB3VGZzSVp5TFZC?=
 =?utf-8?B?REtCL0xibHZvY2M0WFhGUDdlUXlDOENWTlg2eEw4NVI4bDZWcDVHYnJCaFNP?=
 =?utf-8?B?OUZETTNlNGsvdE5qanBCN00zOGwrNkQweWZmdExRQmw4Zm9CMENsWWR2U09G?=
 =?utf-8?B?Nit2djMydFE1ZFNoTmhRT2Z0THcwb3g0SmVHOXJPWStvZGxIRnpUKy8veVAx?=
 =?utf-8?B?TmZEc1kvcXVzb0RqQmthc1BVQ1ZRVnNCZ2xzaGI5cjQ5MFNNeW9LTjZuZEJ0?=
 =?utf-8?B?WHVUaE5haE9IN21abHhYUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlV2V2ZDY0U3U2c3MGIwUjl5SS84bWJjNW1vSlFkUkdvVE4vNzZsTmVQamZ1?=
 =?utf-8?B?aXA0Vy9kUGJSQmg5YnQrRTJQbVFRTmE4ZndZQjJ4VlFIWWRVMTgvbUFFRXNQ?=
 =?utf-8?B?RThCbmxPVEVaVUowbVRCcEtieHNTQUtyMHdZV2dKNURESjZ5NHZ4eHhvaHNG?=
 =?utf-8?B?WXdXa1ExQjd2NzJqSHBKTkRvK1JLRnVzYlZFeVVINDgxeWVnTWF3NlJoTWw3?=
 =?utf-8?B?bXg4a25VdllBZ215eGk3UDJzcWVnVVl6ZGsxa2hhVDIwcDEwc3lCV0RaS1N1?=
 =?utf-8?B?eHdKdFRoRmMwZ084cFgvVDdOU3p1aUU3K0tLRXdKNjM0K1R1TE1GOEhpRWxC?=
 =?utf-8?B?Z21BWXcrVUErU3lITUpQRDVCeHlreXFaZ2E4UktEUlBaR1k2RkdaRlFvZ3Iz?=
 =?utf-8?B?bzBLTW5xMkUvajVvYk5uRVpjVHJuUndwMHJlL1Z3ajgwNXNtODlzeHR2RnZr?=
 =?utf-8?B?dmsxTU1HYmpQT0o5YnRXKzlrMWpGSm54bUZubEhMU2xib2ZCdnJncXVpdlpT?=
 =?utf-8?B?bnFMSFcrdjlXT2ZWbjdmd0J5L21yV3UrR29tVStnL1FhWkZxQWw0QnlBdUtk?=
 =?utf-8?B?aEZZajU2N1hvU2pEcXlJNkFONlp0ZSt3ZGhTYThGZDM1Z0ZVS0FyL0FramNO?=
 =?utf-8?B?bmZLakJuelNxbitCMzNlQi9BMForVGxXYW5SOU13Ym5pRXMyMG03cVNzM29S?=
 =?utf-8?B?a3JHQUVnYzlrUEp4U0gzMit4c1BEa00yZVdBOUc2enhOaXk0NnpycnB5NktC?=
 =?utf-8?B?UGorWkdDbXpMVEFSL1FEb2Rrb1FvL29KOTFWdWR0NDRaRVV6RjFYL1ZCSEc0?=
 =?utf-8?B?M0JGdi9wbkJmdDVZTlNmZnFRSTZqbG9yWTlBcmNNRTFDZkJKNktlUTRjdGVC?=
 =?utf-8?B?N1J6N2N1T1Mydk5CaWRJRytpbDdwZDkxQmNNNDhRRG8yY3YwVnNURFhzMTlF?=
 =?utf-8?B?dGJZS1BTUlBQclovQkhkemIrUDJ2TWl5VzBIaGlZNU1NNU5QWENrajVLTWIr?=
 =?utf-8?B?bmVTeEd4MEFLWldzSXdiRWp6MGxsVmcxMTJscjg2Mm13eDdLcEhXTUl3YWli?=
 =?utf-8?B?UTc0Y3gxcjZ1Tk11bVdMUlV4L1JHTk4waElzc3FCaEg0eXBVSHVIcytCcUFs?=
 =?utf-8?B?WkJtVUN1bDQ3NGgydDkyVktsaC9JRmIwaFQ0cUVwNGZjaEtUU0U2Q1RuQ0Z2?=
 =?utf-8?B?dW02Smt3MG5WUWNwQTZBUGNWNEJyWDE2Vkg3UnZ6OVpvcDQ2V29XNHlpN09C?=
 =?utf-8?B?WDR6L3BFRjA4Wk9LSlZUVVV5S25UVEJPS2Rzamg1SytnaE1ucGlpM0hHeGZI?=
 =?utf-8?B?RWtBb1gycXk0TzJtVlFOQklKNElVOUZFMG04akxkdVVzWGRqWkdjM2FBZXU4?=
 =?utf-8?B?UWlxdVR3dlFxWjkrWEpNTmd1b2p2c29FYmNxbGtuZ253alIzOXl2ZE04bHUw?=
 =?utf-8?B?RUVNNzlMd2F5ekRadExrRzAxa0JjVUUvVUZyZDNSNzB0clhsMUMyK29LY3ZP?=
 =?utf-8?B?SW5tNGRlZEY2Q3NacFFJZnlkcFNsV0tJNWhaMDVyY3hyL2grVHYraXMxS21F?=
 =?utf-8?B?OEhxZEFMUFVWQ0hGdVVDejBsOGh2aUdhbDJNSGlqcnAwSUhKU20zTDVaN1By?=
 =?utf-8?B?Y2p3TzZPdUYyaFdxU1UyTUVWd1FJTFgxNVRtdTlvNlhaZTJkdkVxWFhJeVNy?=
 =?utf-8?B?WGxFaVVMSlVSeGhrWkdZd3NXSmlTWUVkYnB6ZlF4dGZlc2ptbUxrR1BNMnU0?=
 =?utf-8?B?LzB1SDNJZW9ZQlQ2R2crNXp5NTVaMXd0QTFSZVpueHRwc25nVngrUUl3Nk55?=
 =?utf-8?B?MWh6L0dZaHF4WHdSUUlKYlo3b3ZjWUE3d0tMTjJPelRBQll6TkxOb3Uwb0ND?=
 =?utf-8?B?SmhJd3JqNG81MDByRDZJSkdiemwwYzdwVmdFQlVFOG50bHFOazlBeGVwSHhD?=
 =?utf-8?B?OEJ4L1p0LzJoalBTZTgxdW1iV3I1ekNWNkVRRS8xZDNISjV5SlExZnQwWjc4?=
 =?utf-8?B?RUNZcEVhbzBpMkpXZE9SaXRmVVJiVHdzM2Q5b2VjVnBYQUNsaDlsWEYyWHpo?=
 =?utf-8?B?VTlhcjlFaGRqYUtuWndtZGVTcXp1enQ5ZUQ5L0F3S2YvelZsQkQ5UmlibDFW?=
 =?utf-8?Q?CreXSBS9XK+2+oDISDoZgDl0J?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9219ed5-392a-4b89-8488-08dce1576c80
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 13:54:37.9828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AmkePm7E4Lcjot83YZyqX/xkWJMKu3qgly//p/4rm7443tI+HxcfDDUNExsZXzfdr/GXiY+8o4REB3j61MFkTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7747
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Sep 2024 13:54:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16937

Hi all,

just a heads-up for upcoming 1.5 release of isar-cip-core. I'm planning
to tag rc1 by the end of the week and, if all goes well, 1.5 the week
after. Anything that should go in, please (re-)post soon.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

