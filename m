Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68FAE77183
	for <webhook@archiver.kernel.org>; Wed, 18 Dec 2024 08:00:03 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.100996.1734508794235093204
 for <cip-dev@lists.cip-project.org>;
 Tue, 17 Dec 2024 23:59:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=kazuhiro3.hayashi@toshiba.co.jp header.s=key2.smx header.b=GA9HG4DS;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=kazuhiro3.hayashi@toshiba.co.jp;s=
	key2.smx;t=1734508791;x=1735718391;bh=dXDNukSmQKoceage+kLtIVw+7BEcQ2oiTfKIFzx
	hvkw=;b=GA9HG4DSegFBmVpRFlddN3700DJ3eCaACyUzJCzJE8znBCPtRBZAWLr7Lg55aMYtnOq3v
	Bd9f/LQekjxg7HxHQgoIKv52huYefE8+L8GAqnq4flhgitL1Rc2TDaz04z3NUQEYiXjL2CzzxbiY2
	jGFFzWBvvyucTkFiGoZwfeK5lYsT2Cq1MxJjg5N39niM4bPzpl7j7kZit7an/lK0cqhS+0ZO8ISVX
	qBNsM2fky7jFg4TD1bIhydvg1mHb/D06ULmHYcBU+eH0NriuugiK9886qu9OFgFh40PzLX7Ik/gZ+
	OpaPcidxAFD9RUwPsILBtqGpCJunUXPTkxtOgNx0xA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4BI7xpQZ1833433; Wed, 18 Dec 2024 16:59:51 +0900
X-Iguazu-Qid: 2rWhqikybJlwLvJvBQ
X-Iguazu-QSIG: v=2; s=0; t=1734508791; q=2rWhqikybJlwLvJvBQ; m=a27xMQwSEZnTM41T5MSxcXs5pnhHynCfkc/PUSzgPzU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1122) id 4BI7xnE7483639
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Dec 2024 16:59:50 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKjqfhJ0pBQ2mIFcGLM1R3SK8M5qQtSH5yI0EgrDtVMQvFu9eNX7yObD0ZDgAb5bdRVH0xeO+mhIhFQk+8unR5fmlTQx2GKn2sQ3px2Pgtkl7XkGwX2QvZhkroORVniE9CRxjfrOuQA0qDYwtTqqL4MsbRwE4sE2RM48ieacI/iVmdpBDJ6sU7enmFFz+g7cCWPRzxmUoHrZxX+eRtR6zhJVW1BaVMPqkoKrvnZ3fTNpPChyja766mvZZfnmNFM2PiSE3OIEd2yGlgkpd54I5i1bizKYMO20cJM7uelMoqjPQ6Q8oR2q3xFeXryPqKsdIWTj7g3KTlXi8VHWMvLzCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXDNukSmQKoceage+kLtIVw+7BEcQ2oiTfKIFzxhvkw=;
 b=yqKDOExKLMdIvoXORmTkGw5+VPrJx++4FIb4ihRduPdvcKEkYMzF76ykGrg3en6O5zJmgK++PbDgzss8zGl5oS48j+FdZsBAv+2C3mRIMY6WsVhGxQFm9iCefJuhlxz93zgH5WYAPg7en1cztdB2J7yUG8gwWzxfko1iHujGG9pd2pMgoH4vJTIdLtn7h9efbB2bU4AQcFM4U4MPsZJcWM2QkYZ1TRd39wYpwwXmagdootIcG+lSTAOnVge7FqzQlmDg/j3uaWmroHiTGX/y7TKa5l2E56zLVyjrepT9wkJCizzLjuq77WI8qnHvwbyw1nO/bSz9IaR6Su+3mEoLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Topic: [cip-dev] [4.4.y-cip-rt][RFC] Repeated WARNINGs in
 unpin_current_cpu()
Thread-Index: 
 AdsJh4OWhCfjKTeTTpWNGegB8O3M+wKZptcAAyMC8oAGUKjG4AHAfXyAACXVkeAAPI+ogACE0nfAAjnJmaAAkRe6gABlpKzg
Date: Wed, 18 Dec 2024 07:59:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB11385C4C5CA765090E66944FFE1052@TYCPR01MB11385.jpnprd01.prod.outlook.com>
References: 
 <TYCPR01MB11385E3CDF05544B63F7EF9C1E1622@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <ZvvRQmpIm4UHHhGS@duo.ucw.cz> <17FF38206FDF8135.11625@lists.cip-project.org>
 <TYCPR01MB1138579CA7612B568BB880652E1272@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0cBKfpz3I6pA4MW@duo.ucw.cz>
 <TYCPR01MB11385501FC495E0F4E531A749E1292@TYCPR01MB11385.jpnprd01.prod.outlook.com>
 <Z0mVe42i41SXemYu@duo.ucw.cz> <180D3C69AE13A59C.18476@lists.cip-project.org>
 <1810B3A8127ABE18.31077@lists.cip-project.org>
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYCPR01MB11385C6C2D03D46AF20294DF3E13B2@TYCPR01MB11385.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11385:EE_|TYAPR01MB6202:EE_
x-ms-office365-filtering-correlation-id: d9185943-2836-44fa-da75-08dd1f39f110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RWhsc281cVVYb0ZOTkVyUFl1WXFHU2kyM2ppSWpFNWtpc0tDbG8rbFBQ?=
 =?iso-2022-jp?B?by91ek5RNHdyZ21WRlFvcURrWmxQRTBlZHJrSnN1aVBSL0VyNE13QWxn?=
 =?iso-2022-jp?B?RGNadkpVdlY0UktrSzdCdDBYMUNOZHFOZnc2WDlGL252aDJJclNNMWxP?=
 =?iso-2022-jp?B?c3NXZGVnWmdEbGMwRlVaQ2hZNnVOUzNRYW9oUWlwVmRuSUFJeSt4eENQ?=
 =?iso-2022-jp?B?NTZVTVFSbkQ3czIvQ1Z6RkFNMmlCcjd1SFI5VngyUS84dThScTBCRndZ?=
 =?iso-2022-jp?B?YzlDREZXeFZOVElCUjU3dWlGOHBQMXdNQWlFWXpZTG93ZzlkYWx5MVZP?=
 =?iso-2022-jp?B?V2Y1dWZGaTZEeUNyUVBUWFFUVHo1cXRQT2w0S0d1VjlCNjRqT1ZYNnVN?=
 =?iso-2022-jp?B?YmJCTU81ei9DdXJXVmYxN1NMcVJBNHNmZTFBZldtdTMrcE96TkhTWXlq?=
 =?iso-2022-jp?B?ZmgwZ0VMVEdWZmVwaU1tTnJMNDJuZ0V2OEh3Y21lc2V4NjVPZ0Mvc0dR?=
 =?iso-2022-jp?B?UTNPVE45dmNxQ1JoOG1XY00wc3R6Qmo5UkoveFJXVm9YYW5kZGI3OHNs?=
 =?iso-2022-jp?B?YlNDdjcxQUhua3VhaStQYzJqbFJXVjUvSnRWTU9Yd1ErQzZRZnIwV3B0?=
 =?iso-2022-jp?B?YmN2akVpeXI4NmZIQ1ZPMU1SVC84YzdRYXNMUGNSWTQycHd6RVhPOVlN?=
 =?iso-2022-jp?B?V1NIWlo4aVlMbHdybFFOMGw5c2tuYXlhU3NKa1o3ampDME1kbTUrSjlu?=
 =?iso-2022-jp?B?Vm9CZ3lQRzkxbUVVaUpuKzVkTlpTMmJ3VEVyMThSRjU0cGR2cWh5WSs2?=
 =?iso-2022-jp?B?b1UrRjB3VXdnNHhsZ2pXSUttVSszTVlLMHJsbUdZNGZQTHQrUVRNbVFy?=
 =?iso-2022-jp?B?VVF0RGwyMUtqYlhET1g0M0tUdlBiUjB0TU5DMVJEU2NvNlRiZFhJV3Az?=
 =?iso-2022-jp?B?Q0kwS2dib2hGdUtBVFFjaFhocndkTlpYeFc2bXF0Rmo3M1VDVEZtTFNP?=
 =?iso-2022-jp?B?ZFoySFk3VVBTa0xmNERsSnE3SGJwSEFsYkVBY1NKeUpzWkxMNm1HTWNS?=
 =?iso-2022-jp?B?ZlF4VFNaTlViVC9lWnh6cnM3cmRlc2FzYmJ1SkhKV09tdUQweFFMcC9o?=
 =?iso-2022-jp?B?UCsvakhkdGR2V0RaeDNaaEtPV0p5ZzIrMzd4QkdOdXJYTnc2YW9HTFAy?=
 =?iso-2022-jp?B?a1J2bC9ON0tadVRXckNKeGQ2VVh5V3JqTzg3OHRWYndSeC9mcFlNbFJu?=
 =?iso-2022-jp?B?Nlh5bXlXanlTREpRQ0s0aTFFMGxlckJLeXRvMTA4ZS9xclIwalVDSmp2?=
 =?iso-2022-jp?B?RUpiVmplUVNONkE1bzZJdjRCTUFNQUZEakUwUFQyci8vdy94WWRpdkc3?=
 =?iso-2022-jp?B?dVBMSm9jYlN4bVZTUWhFWHdLSkRUYi94K1piSThVRHJvY1M1TXJGRXNy?=
 =?iso-2022-jp?B?SFZtNHhRd1cxTUdBQlBmd1M2V21IMm1IdmdEM1hmbklxenpoQXJlYzV4?=
 =?iso-2022-jp?B?N2lYRzhkWHlCOTJvcTJ3NmlIZGREZjVlSU5tclR4N3dPUStrN3lkdlc0?=
 =?iso-2022-jp?B?TWxPcDRlc0pOa1NWSkNOY1c3bW03VjhXVE5nTUJVSFpVYTFDd2hVM010?=
 =?iso-2022-jp?B?U253WFFpQkpCM0dkQ29JKzNacnNIZUg5TzJxV0ZOVUdiNFk4eFdVTTZt?=
 =?iso-2022-jp?B?bGpjLzBLelFWWWRGeGhRajAyeU9hQVpQOHdybFc5Q0wwZ09sMm5DVDVy?=
 =?iso-2022-jp?B?WFFNejdIdXVOZllLdy9ualJ3TjJIa1FKaERKaWFkZjZtT3NsYWlxSEdp?=
 =?iso-2022-jp?B?ZG1rQUl4Z09hendrcU05bTYxeG5nWmVmYUZ2QytYMHY2T3M2MEtoeWpl?=
 =?iso-2022-jp?B?eU8vaVZnaWR1MC9qKzhpS3pZbXZsRVh6UGsvUm0yRjdiZGY4YjF1YjJo?=
 =?iso-2022-jp?B?QjVqMmp5YkhYZ0RDbDdnSGE2TzJBRDk2YjNnWEhrN1hHK1JQanZRalJV?=
 =?iso-2022-jp?B?SWdzK0Q0K3pRWFhPOSs0OTVocTUrK0k1WjVrOFc3RTVqSDZSNjZ3SjY5?=
 =?iso-2022-jp?B?MXo3Y2NDYktSYklIRCs5SWxtbTVFS289?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11385.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?YjJCMzVtOENJQTMyQUFpdE9wd2lqUllmSHRnN3NkY1Bhcnhya2RvbUdp?=
 =?iso-2022-jp?B?RjZjbVN1VEJRajJoR1pieU52cDJtTXdFLzE1WEJkdnhxSlVqUWo2WkRG?=
 =?iso-2022-jp?B?cDc3eHQ3VDZlWGN1V092VElyMnE5SlppTnlhSkw2L3llNE1vZzVYajVx?=
 =?iso-2022-jp?B?bUpIN0JkaTlTNGtFQWJDdXRNdjJqWXd5d0Z0cXhnYU05WlhuejNwWWEz?=
 =?iso-2022-jp?B?RUh4Qnozb3BpYmgyemZLRVZwWXRGUXBLZVprS0s3U2NBdkoxeSt6S1RI?=
 =?iso-2022-jp?B?blFFTVBpUytxRnkrZ1hYRkFYWk9WZWVmeFVnQ2dKcW90WmlmZk5ESHMz?=
 =?iso-2022-jp?B?eUF2MWVkNFJEWEtXQlRzY2NVQjV0eVhxS0M1NXVJeUQ5MmczZWVlZG9a?=
 =?iso-2022-jp?B?WUFJcXVlWG1HTDJGa0pUeDBRenZMT3poMlUwazRpbWFpRnVjTTVzOWtG?=
 =?iso-2022-jp?B?c0JvQXpYdCsveWtyMlZaTFpGV1I4ek0yN3VIVk9kNVBBTTRwdmtnK1Js?=
 =?iso-2022-jp?B?d1RKbWYzMU9wK1kxMzRiWjRCR2hzN1N6dGp6dmNpK3pzbUtwYVhqdUpp?=
 =?iso-2022-jp?B?SkhaYWNJQXNsY1pJK1NIMUFLWkU0c3lqck5qL2RTQy9CN1JkcTVMUmJP?=
 =?iso-2022-jp?B?cGVkN2RGcGR2WiszRUFMRGJYRWlMWUpIbUhOUXRsRHhseWd5ZlV0OThT?=
 =?iso-2022-jp?B?amd2UWhTS3VUcGJYa1RYUWNxS1V6SzZlYmNId093WHE1Z1NLeDlsbGNC?=
 =?iso-2022-jp?B?TE5DVE1VMGtrRDlmVjFhVnFheUl0QXhyVlhBRStYcDNGSzdJWXRpWm13?=
 =?iso-2022-jp?B?VEU1N0ZwdTFka1BCOWZkV3NPaW4vUkVzMmE5SXRpQ3RmUUd0L3NoV291?=
 =?iso-2022-jp?B?cm93OFF4Z2UzN0hKb0ZRWjQ0emdzdmpMRVliTXRzTVgzcFhoM2J1Z0VO?=
 =?iso-2022-jp?B?eVQwd2NvM0FXTkhIV0VUUkRTQTZ4WG9EM2lOaWZ5NnkyTjYrRWxEa1ZF?=
 =?iso-2022-jp?B?d2xyN0FaeWxTaDMybzQ3T3htUjhnOXJLcGR4RUZuTTF4a2RnUTZsRU5Q?=
 =?iso-2022-jp?B?SEQyVll6U2xDSDY1THRxZ2JvYzNXYnJseFZqdTVrMytBQXRwcXdXZHg4?=
 =?iso-2022-jp?B?SHZ4cWZiN3NVWlZNTllrMm05YVNqdE1yU3JUbG1qSWtNOUdHYUdTcnBa?=
 =?iso-2022-jp?B?UXVDM1VYUHllUWNoK1ptWWs2N3NJYlpRbyt2U1E4ZFNEWHB3RzRxOVVL?=
 =?iso-2022-jp?B?b2R3U2RQNkdLcHd0eHhuK0RHSlluYmNxSk9tQU1FUmJwVnpMR3RlVnND?=
 =?iso-2022-jp?B?bXhIWjJPcnA3eHU1aGFiUWN1T05qQWdrZmZPdFJZc3Nvekt6VnBEb3dZ?=
 =?iso-2022-jp?B?VkhUN0ZkVEUrd0g5cFY0YUd2cjQwUkJvNU96N1J6NDZPTXI4RUZNVXpV?=
 =?iso-2022-jp?B?Yko3S1VGdU9rcmE4QXpmSG1FeFlvbTBkeWgzbTh4NkozdTR6cjBWK3lQ?=
 =?iso-2022-jp?B?bHliQ2xkdytnb09zOHhRWUUzVWZqc1U3QllCS3pTZ1I3SDZ4MCtPVGpq?=
 =?iso-2022-jp?B?NDBzZUxYc1dVRU5jTENCNnJPcnhzNGF0TGJvYmVOTzNzVnM4WFNzNUpX?=
 =?iso-2022-jp?B?WW5YU2hoYXFaZU5oTlVYSy9yV2tQWHloaWM5NUpUU1BVazdpbzk3SDF1?=
 =?iso-2022-jp?B?MFBQM0czS0Y1d1ljWlVjVlhWdjY2c1IvMEdPRlNtMVRENDIvOG5JMmNB?=
 =?iso-2022-jp?B?SURIQjZCWjlXKytONGxQRlZ6QjFzMjZlaGlEdkp1RzlKdlpFNlhaUTRi?=
 =?iso-2022-jp?B?ZGFnTS9xbmkzMlB5N3U1bVQ2alVIbFhqN1lGaXhRV0VyRGZkZDB1RHdI?=
 =?iso-2022-jp?B?d1E3UTMwdXBEZnhJL2JnVGp5U2M5UHRNdjBCN0JORVVKMWtLUzhreDFK?=
 =?iso-2022-jp?B?L3BSMUFtNGREYVN0VGpMUzVMa1IvRUJoamJlSWpZb2JpNThORkQ4Tk44?=
 =?iso-2022-jp?B?NjBnOEs5ZFFnY3Bvd2N4MmVoczFUdVppMFJXcTBjQ2M3NjRyMFRnaGgr?=
 =?iso-2022-jp?B?Q1UxcjZZejB6QTh3cGM4Q2dtYVhVWEJhSVEyYUs5M3BOWThBeWlOMHNE?=
 =?iso-2022-jp?B?TXNWOUZRMUpEVU56YUJHenRuK2lnSUtNZkxCalRJY0x3M2hrM0NSSlZS?=
 =?iso-2022-jp?B?czNsREtTWFBCbkVwRGNPVFA2RXJsV1BHakMzSnVqRTF1SW5ySHBqK2FP?=
 =?iso-2022-jp?B?c2hZSGphVFh5dXgwdXhZQzdBeVVrQ2dYbGloYkJhNHJJNjFUZ3ZibkhY?=
 =?iso-2022-jp?B?N2d6dXIvc0VDOWdOWFpiY2JCRElnMlYwZXc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11385.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9185943-2836-44fa-da75-08dd1f39f110
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2024 07:59:47.4438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqufhifHCopNJ4Ursm0q+oOqSCYfHMwZkCfxo7F9NL/oNkEK5nlGQV8Dhnr16WpHjSIuW55nwEkwBTi/JqeDTIx6XrAnkPL7tQ7C/VQ3r4LPQb9P+QZiScSsOtQMQ/v6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6202
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 18 Dec 2024 08:00:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17442

Hello Pavel, kernel maintainers,

> The memory allocator seems to be responsible to enable IRQ properly based=
 on
> the "system_state" (regardless of GFP flags of its callers).

I checked newer implementations of mm/slub.c especially about IRQ enable/di=
sable behavior
in order to see if any other kinds of fixes are available in newer RT kerne=
ls than v4.14-rt.

From v4.4-rt to v5.10-rt, its behavior is the same: __slab_alloc() disables=
 IRQ (local_irq_save())
then allocate_slab() enables IRQ under the following conditions.

* v4.4-rt & v4.9-rt : gfpflags_allow_blocking(flags) || system_state =3D=3D=
 SYSTEM_RUNNING
* v4.14-rt & v4.19-rt : gfpflags_allow_blocking(flags) || system_state > SY=
STEM_BOOTING
* v5.4-rt & v5.10-rt : gfpflags_allow_blocking(flags) || (system_state > SY=
STEM_BOOTING && system_state < SYSTEM_SUSPEND)

Interestingly, in v5.15-rt, significant changes are applied by the mainline=
 patch series [1].
The codes to enable/disable IRQs in both allocate_slab() and __slab_alloc()=
 are moved
to ___slab_alloc() [2][3] then adjusted a lot.
Eventually, the most IRQ enable/disable codes are replaced with local_lock_=
irqsave() and
local_unlock_irqrestore() [4], which does NOT enable/disable IRQ actually.
As the result, the most slab allocation functions (except some free functio=
ns) are
fully preemptive from v5.15-rt. The GFP flags and system_state are no longe=
r considered.

Based on the above situation, I concluded that it's not possible to backpor=
t
the changes for mm/slub.c above from the latest kernel into 4.4.y-cip-rt
due to the significant functional changes and refactoring.
Picking SYSTEM_SCHDULING and related changes up may be the only way
to resolve the repeated WARNING issue in 4.4.y-cip-rt.

Please give your opinion.

[1] https://lore.kernel.org/lkml/20210904105003.11688-1-vbabka@suse.cz/
[2] https://github.com/torvalds/linux/commit/e500059ba55268e1c5212632e4f21e=
45f54dc6d9
[3] https://github.com/torvalds/linux/commit/6c1dbb674c5cf76d233811605
[4] https://github.com/torvalds/linux/commit/bd0e7491a931f5a2960555b10b9551=
464ff8cc8e

Best regards,
Kazu

> Hello Pavel, kernel maintainers,
>=20
> > I'm checking several codes in v6.1-rt where the early might_sleep() det=
ects BUGs
> > while kernel booting, but no fix from the RT perspective has been found=
 so far.
>=20
> Please check the attachment for more details about this investigation.
> Here is a brief summary:
>=20
> * No fix about the bug callers is found in v6.1-rt : (1)(2)(3)(4)(6)(8)
> * __GFP_DIRECT_RECLAIM is set in v6.1-rt but not a RT fix : (5)
> * The bug callers are removed (cannot compare) : (7)
>=20
> I concluded that there is no RT "fix" for the might_sleep BUGs in newer R=
T kernels.
> The memory allocator seems to be responsible to enable IRQ properly based=
 on
> the "system_state" (regardless of GFP flags of its callers).
>=20
> Thus, I'd like to check if CIP can add "SYSTEM_SCHEDULING" to 4.4.y-cip-r=
t or not first,
> then have to find another way out if that's not applicable.
>=20
> Best regards,
> Kazu


