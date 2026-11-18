Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.62])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9163.1794995019800551639
 for <cip-dev@lists.cip-project.org>;
 Wed, 18 Nov 2026 01:43:40 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zCAu5ggV;
 spf=pass (domain: siemens.com, ip: 52.101.69.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDnpgNJrjRgjXt1zwcSyKZbyuRv54qBRGZbkWNrhSuY8MmY9ifir/ntE9MEJ07lND+AzneRtcF3DTmAKvPxyrJqbyrEgYDmkFjuT42I5/AuUep3jcLJQi9dozPtuVrLsVnifcCJ9RH6PlZTUujQU0hse3iuORWFKo6oSXT8wpx3lTy8kPfmlQZEpy+ptgycu2wJIXE3WcZVtyb3aMNixxsRyaCCgA1KtQzufBGEM5MHFL8I93z3/8h+Y/c++g8mzBhoMPEJGJODMJYwlugtP8/qUqCltuKCnRtexg1SQvW2oZx/VuC4vZ08RGHOduxQc9fP07lvBVGFFBCBwirI0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+AZDC/1F2BDT2FkpM7+F/mZbVlaH3DBcUyLL5Pht9SM=;
 b=Tim9umeo5RiRtG72BV4UbcT8szLpWQ9inStWtaXctKR8gt8jC1nxMQHeWwxp970voTmddLZMkK/W+LFRxF9kKrZIsB/XPwlDEqwuOapsYRPStwBhxaQXvuudcaSg3qLD/WkWZkrZct/PSrRxLkyFnOfiVYOd/kBmiADtoiqPKzslEFmQyGFkzz//6CdylTDVJ8IdxajTxRH9baEcGQK/npmURcVMHQXeSDRotXF57/xtwAupGmKmDzjke+wmDamrt2zRX8KUuAX3sMO9HmQE1EDJYmnQUCs1IRicYDjo++rfcqiWP5RInjxHHW6u7RmKOOIP6KUvaZrga8km/dWfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+AZDC/1F2BDT2FkpM7+F/mZbVlaH3DBcUyLL5Pht9SM=;
 b=zCAu5ggVKbXJD2GynX35+FbecL/tu9r1JH1PPkX6OtoTvr+HiXQgrFSXOOnMBtNxzfq6EuELKmH8LHnzbiGLi8nDoXoR+UchlbOwXyORJatTeJnufC0ASd3OpkgpAHQdnjVl1/WdVOLMa0AExtbCm6+NAKwWS/Ckdz4PyRJhPgOaTJmwPgkKojs4CUnA//gvYoX10QPHxYpigjNlFU3Tvdq0ufpSdPhNQoweRD3wOhAmKPJ8FDJG4n9DQxs/+fYjZ6byEFlZWQr6aKuYlfDnkKnbcPtGMXXE9gup/KdD2odwWIKZ4XDKCH2PhCsAZsrzx0V3LMf3F72VTVBWv1vKBA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA4PR10MB5585.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.7; Wed, 18 Nov
 2026 09:43:36 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0639.005; Wed, 18 Nov 2026
 09:43:35 +0000
Message-ID: <e1b55163-04a7-4e49-af02-2ede35b29434@siemens.com>
Date: Wed, 18 Nov 2026 10:43:34 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: Chris Paterson <chris.paterson2@renesas.com>
CC: cip-dev <cip-dev@lists.cip-project.org>
Subject: isar-cip-core: Do we use some where qemu ext4 images for testing
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA4PR10MB5585:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a9d403-2844-4116-970d-08df45586a7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|10067099003|11063799006|56012099006|261021121427099003|261102123227099003|261022075727099003|261026121527099003|261022115727099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: lD1F/ynk4v6jALfNmSEXY8yY/mxZ/SeZ9mE3ACh+IPoapTdnUWpbG/XIClZlQdmEOQQZ7WusE1qsWJ8UG4mHBFbrrvgP+KyNhn1xlALIfBImZwR3b+dRqIPqVijLroW01DcDS+LXpPXv60sFBcREgsZd8ELOyE8ELcpmsAbs03ZSGEIEgFpV8giJpxQRuOIlODjuV/iABE9/pUpvCH1pkRrjQCDVc1sF5X/9tR5+Cu6+tEfgZwefi3FNEb8oo3Bl6syA8Y+ddqzSuNERJroaJOFPs4j2oxKcmIjjqt2hVis3ByHZSnUYOryCb8N0B1b0q5MfXRA0vDp6tUv4CmgfLTlfC8QmlQ1H3XOudSO9Ec/wZi1LG6QCGwc5jjOO7qQRdG7GDUKAHW9vPgUXf7keyoViZD1komb/r2K0MCsOJ7i8r2PI8MX97draLdtSouZFuft1cetMhYC5dg3oBgyZe4h/PYdNAkBJV19Q3I5uva2J8vmYtpSHEz7cC+iYRK32fWxVng8VNIscjGlNKUPjSZCLrIUYaiXsJYX/ZwbZXHbhYegoMVELK6YKD9t//AF5bfzM604G3C2zAl7lErlKmsLXXbaB742n8zzOeZWed3dYQNGF6cTyBMlSn6DOxZzoKOLKJTX5kWyVkzxRgv98ZSK/BqqDHJAyq3prDGDcaaw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261102123227099003)(261022075727099003)(261026121527099003)(261022115727099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?U7j/N+4DhbJCikR84fW2aIQdEgfEhkcjqfyd3zyff9yZBglKyiyDTW43BVY6?=
 =?us-ascii?Q?a9y8M6zY0B5kDYTMkKszcaaTmfZfvNM5+v5MCqAzSxi+r/a3gwHn9mHKelJ2?=
 =?us-ascii?Q?41g9pN0R7hM2sXdY1Yg74MOPCUewi+usfJljFxTonHRozGxr0Dquipo0yCwN?=
 =?us-ascii?Q?bDf6U5oTuPipXcsA9KXdL+N2FGfU/nG2/Q1R2TClarKSfPwOEsnODNZYjdUn?=
 =?us-ascii?Q?W8yDbU0GN1WLDUhBb4Q+IRIxoaTqy5HmWDO+y9dIQdBaq6jiFGhKw4OpPBti?=
 =?us-ascii?Q?B+H3TWMHAtV8lopmStbKrU2D4hoddVHFmbGt7w1mcWeNlOwYyN676no4hFF8?=
 =?us-ascii?Q?yL0mEhFT0FouDoWNInejOAe6Xi54n+eByZdDU8vrQU3ahFRa2NEGnbZoOApA?=
 =?us-ascii?Q?TTOG1QL3N7DvG19gJXTZv6lE4tRc+muGTaJ1LrsK12ED5jjFYXpqajLhP7CQ?=
 =?us-ascii?Q?CepAN77P4oyePSl1TlpMv+681Q5QkLxvBKCOlvcF3zZKcqbtDoDj4Slfj7Qj?=
 =?us-ascii?Q?FoAbhPENUfYpbxCLM6XdgbLdfVVA9YajQWc0JFfQO5BIHqZJERR2D9hP+mnM?=
 =?us-ascii?Q?Q1ZAuYHwF+v4QLXpy2Cmau2YvPSo5OMUFKiincrLWfjKvmB/iBOH1Hlh0yvg?=
 =?us-ascii?Q?IqovaacobdfI7a+g+8QNxKTisGB5gAKS/5TBevvhi4Mv2X5YhfLl7R/cm5Lz?=
 =?us-ascii?Q?lv6ou3WNhpy62rZ6widsP1QAfbgicoSrl77KWjndm6VdAbAI89XGJtdxOEVV?=
 =?us-ascii?Q?YAbvgb6PP6w+S8WsnNCc48wc/nGNMW9k0OEp30mXSdq+rLuSqk3rCOglPs8e?=
 =?us-ascii?Q?J+Zaa2oO5mF30sS/8WmJcKygwubfyrlQu7juN6yfqjNeFnrq1CcoxjEFKqr5?=
 =?us-ascii?Q?i+N7xwZCEu10S+bx4iL7kHdXIEA2k2Sr6bgajrDQdvjW3mIrvlzZimJkNK4W?=
 =?us-ascii?Q?hPsp62fOlPiTwYE/e3BbMSZzfJnz8B4EipCSqJG9rZtflUtEI/CiMeibOmnz?=
 =?us-ascii?Q?OsiGuUJBok2Diz7PKNki+QU1nbQRxy9fe1gwkt3QDUJrHP7fgA+Yr2QzS+WE?=
 =?us-ascii?Q?zvdFJlyfnrFCjPO1GmwX5kvE25jIJUFfRlGP8zvo/KEBTzJnrnaVDcGRRSGY?=
 =?us-ascii?Q?7g9yDJZ5W6SXSM8+ihY5P0FF0YAUXFzHF7qZcdjJ6mSGsnfrDbfpQSf0vHOx?=
 =?us-ascii?Q?FVRQ4wFVFO286YYVmVgwJmzEXaVOEmSJkcnkEdE5az/tmtJsFtg4/VYIfOBP?=
 =?us-ascii?Q?KZ+HKWo2sQhf3pD44LTYJSvPd9CpvJIMT3+t87SMiviQuVjb5ESwKXA2hyNl?=
 =?us-ascii?Q?ZjxIlqSvWrMVWbyZRiiM/CtyBmVT/8VtNTns+xREPB/YeXjutPinBD3xmOIO?=
 =?us-ascii?Q?ckXl89rMlJU1wTy+n8ge016NMDUuUsBnvbqJKpdFc2npr/T8qBV5JpYa42U6?=
 =?us-ascii?Q?QNYX6S4btJY0n5UG/e2hyqauWuEOzTBCrLPrUaxWAK1+u2ODtmFqKelv4FAq?=
 =?us-ascii?Q?OKpPLcPHh/DzZe5NDJncvQOY4xjITPTs0ki1fNVwHt6VBN7ld1F4pUPzus+/?=
 =?us-ascii?Q?XcbC4ZwSPfG82FZbD7fYgE+boYZjnJZXQoBsWMcuiOrL2jTZo8ymqqPtiSuc?=
 =?us-ascii?Q?pQbpHjIGMdULr/uC4W/SWS7Dk1WrEYThPFYB3fv232Xd1Y4ZUy4fUncACByO?=
 =?us-ascii?Q?BsyNywJuGtaw4rMlDhDl3Ruv4dFjOOKGV3OF3drGpPDTcmOOORbCo4+grrlT?=
 =?us-ascii?Q?janwMfoVM869aNUz+YDf0CMAjuNKLVQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a9d403-2844-4116-970d-08df45586a7a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 09:43:35.8112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVGxLxzbyDSRJ80lCfBu2FfLb9jM7EvtckxeUXZGWV9YLtd+wdVMLo01pbyJVJuYoC0FsrpJOWczagqJyCGs9b5uLH6eH8lpqNovgD/nYag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB5585
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 18 Nov 2026 09:43:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24952

Hi Chris,

do we have a test which uses ext4 images from our qemu builds?

I did not find any in lava.ciplatform.org.

If not I will drop ext4 from=C2=A0 the builds.

Thanks,

Quirin

