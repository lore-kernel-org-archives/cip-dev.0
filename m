Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD7DC433F5
	for <webhook@archiver.kernel.org>; Thu,  7 Oct 2021 05:08:43 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.7481.1633583321383510131
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Oct 2021 22:08:42 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 19758dbV025423;
 Thu, 7 Oct 2021 14:08:39 +0900
X-Iguazu-Qid: 34tIWSYHCEComqvDOI
X-Iguazu-QSIG: v=2; s=0; t=1633583318; q=34tIWSYHCEComqvDOI;
 m=GksQXCPvWzASXREu5WHiORcvR6NKCelz3ULbbFx4wKo=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1512) id 19758caS023917
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 7 Oct 2021 14:08:38 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 0F1021000EE
	for <cip-dev@lists.cip-project.org>; Thu,  7 Oct 2021 14:08:38 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 19758bEu020296
	for <cip-dev@lists.cip-project.org>; Thu, 7 Oct 2021 14:08:37 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FumsKMw9u+nEgOInsbN8cFOWNWPn9yKKaXx/vBjmVqG+Js92qvC/B4nGOENwj4fA2CMRYWKoZ8i9tnFHIk9QO/QYJt99abQdJnJ5unppX1SD1QWGnE8ML5puNpcLt7Vs/QQXfJfRYSDXMmjxihYULbKLW7lX7AnrkDYp4iXkaZGovDjGIB5oGVcIXxBEpaMm4Onaaiv9xgY3w2dBHgeTNVP/PXU/nJEPBu/1EYBmZtvtdkOHGHvxm25fdOHtlVcbYQIfUlNEkeq+mmzhwel/IpwC8x9CSklXNU5/9FLS/rnv0gl04fhDIgILErZrMLgPaKbNK5KC7JboY2jINvg8UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F6Pstg3XsFHaB4+h09e+RzkaV2up9NSYlGXtRa6VdI=;
 b=MPn7P74LZ50cWFuH7siPU1YoPJ9xVsfgqnzTKdqQL8YKhxQvVie7ZPfaOWXDQXrPgfQ+BTGCeTLk9w7KkH8IghCPXoLuWdZgFmA/ez6QmOFmSJpfr2zv7DZtn0zoRwLI01soiol9LX/yp5uM4i3+2roIPOYWMVayac4qSnyokSWiAR3d7lzFmizRfgimTZExQjlgnYPOyQtk6pqNy2CFRENjKMbClC8QCI2l5/KAsh/G+DwH00ZHT995kQ8hxl2IC00eoRBo/EfWbtMsq6BNI4sdekcsgszwmvp8R/7OK+mqjMO66KEJJpjDbXqwJWT04Xxi1H0yXWQhlEWx1EgnVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: deby: No certificate for https://git.yoctoproject.org
Thread-Topic: deby: No certificate for https://git.yoctoproject.org
Thread-Index: Ade7OMEs7++K4DmQRUmVdlSdGp4zSg==
Date: Thu, 7 Oct 2021 05:08:36 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYBPR01MB5502233ADF8F0D953396F0C2E1B19@TYBPR01MB5502.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
authentication-results: lists.cip-project.org; dkim=none (message not signed)
 header.d=none;lists.cip-project.org; dmarc=none action=none
 header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6905bcf3-0d1c-4899-b7a6-08d98950847a
x-ms-traffictypediagnostic: TYAPR01MB5401:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5401E5B5C5FB5D4F9179123AE1B19@TYAPR01MB5401.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 Ri5VT8Vszp3a0zd4vn3cV4Vao3no1Q/QAxn7Gxi+y5aM7TLY7lT0w04aSIYCGwjPwF/gAThGvQTeAAnkJy1q1Us38VCjrdHS6WTCmKRfVg4j6RaMdiHJ8HcQkcDxWM9jkHawnjJqnpv/kL5BSFQ8Ynhk/JQSqCqewb/Sqkaux3s1E7f+HoBvdoFuY4glUZEPIWW4zl22wNdzuT+FvQOCTSHYY2H0XAJLHtM5YdqQhPmW5Pya013NTNaqVowz39DPITJZ+gw0lXa2mD4B9Q+zowHmE655oHlXvQ9YqwfDXbUaUB1NjLb3IQMwqGjX0z4M6HiWBLeG7XK7Ju9NIehWSzYVHlW9kjYEqIoceZt9xRzcISWk/gQcVMUK801GAtqv1mH9F1U9or+Z0zNTfFhhK/6tnN3YEQ063HOQycos6djjZDOh7R8/YnSuA4oxeb2UBQJ7pOdu4w0FLW1e0hFWdO9YaNm8uOuC7vPPmvhyB07rAPzc7MIlIcslPxCj0IHvoT3a7VwzfGkY5jMFweZOAX2p/vBF7A6LwFt7CRbK0wgqVIHoI25L4mUkb43MD5LU3YTKxsDOUes16IqaB9qVzlJK6l0Yn5cpUStQ6S/t9ZZYyHhCkoEEdH0aPTElcrpRPXvrAPm9yeRvwAd9vdlt4e4AWWVIQWyfHMWVb3DF958TOramIaevyNOdv68LrjwkOHot6kL7qDX66YKyXFAW2qXGShBDjkcIxA/85PHGukyWh6wCmiiS+aKAKPsd1znE9t7cvMCAVSxyI9OJ7zNnN8HDT8gy/xEO+4kUSOH4k/YCt2V+9u+P4N/yfPffPxPnMSIRxesuQBvB0cTZk1jmDA==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5502.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(966005)(7696005)(122000001)(8676002)(4744005)(38100700002)(26005)(33656002)(38070700005)(86362001)(55016002)(9686003)(66446008)(6506007)(66476007)(66946007)(66556008)(186003)(6916009)(76116006)(64756008)(8936002)(508600001)(52536014)(316002)(71200400001)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WmZyUGhHSnkvT2w0b0d3VUJHU0xZdlJTd0orQnRLTVI1V2gvK09YbHRQ?=
 =?iso-2022-jp?B?UkxXNkpEaHlJRFZRN1NyS1hjZnNJUFNUM2M3Q1llcUU0NzRkaGNjOHlq?=
 =?iso-2022-jp?B?a2FFTlpKRTE1OWR0ZEdEQUtxK3N0Qlk3SWJDWjF5dzlNVXJaRC9EZ3FL?=
 =?iso-2022-jp?B?SHVCWjZ5aGtsVUxKK1JKVkptdUVOcE5UcjY2amtybUZCSmg4ZDgzdHRC?=
 =?iso-2022-jp?B?ZkIvOWFGcDQyR1VBTnNXZUVXVmgveHAwTmRBelRxMm84b2wvSEhXUXB5?=
 =?iso-2022-jp?B?WExTSVllLzJEZVd2SUJQK1NSdVdaQWFTRkRvMnFTWWxMeXY3TTZnaEhq?=
 =?iso-2022-jp?B?K3hLSW9Fd3dBR29XQk5QOE0vYUd5ZFN6U0hJREg3UEVwWHJTRGc4R3Zz?=
 =?iso-2022-jp?B?dTQ1am9wdDJuc015Wis0Qi9WY0tEbjRFckd6RmYzNnNpaWdHTnhPTGFB?=
 =?iso-2022-jp?B?VndWSWt6dWhYcFJqR2syTkF2NDNBa2hwVFVLY0dnemFrV3RnZ05Ia29p?=
 =?iso-2022-jp?B?cWlSc1pSS0hqVTllRUJsbEZCUmFCRnRSNTFQTkVocGYwQllJZ05qanpy?=
 =?iso-2022-jp?B?TjRPR2t6Tm0ydTM0R1ZrZlNMUTVCQll5TVFUenV0R2Vjckl6dENTWSsy?=
 =?iso-2022-jp?B?d2Y1a1Qva3g2NytONTRQemVRL09NdWZ6SEp3U2tJS0FndThoYUI2bDhV?=
 =?iso-2022-jp?B?UW1sNDdvYjl2ZHo3S3g2OWZyQU9pUWhyYUtiSFdBaXlCTklnbFZ3anRo?=
 =?iso-2022-jp?B?cFA4YVRNLzFmV2dXcFQ0TVIwL2Fpa1hQbHV0ejZNSXFTNjZPUzdCNDVV?=
 =?iso-2022-jp?B?Y3ZPYTVDTWlQaTczZWZQbFBZT3JaYXYrM3ZEamJZY1JWYm1GUmNnQjVt?=
 =?iso-2022-jp?B?aUM2aGZSUGlHa3NGbXFzNm5WUmhDTkI1bWZZWFIvc1A3WWpLZVp0Tm5m?=
 =?iso-2022-jp?B?Ly9tRDhtbFZyY0RSWTdOVDJtQkxZWUpPcXAvN01IUFQyVkZGQ2dadFh6?=
 =?iso-2022-jp?B?MWNBbUhNR3NQSnFCRnQ4Z3htQlZJaHZER3NPNTVBNTJCeXh1bUlhOUlS?=
 =?iso-2022-jp?B?NzdRTHRmTzMzcjloYUFSVDZwaUxQdkdEcU1HTFlqSTFSVm45dUllQ2dV?=
 =?iso-2022-jp?B?WTZnVmNqM2NMT1ZwSkhwZG80UTBqZXdTbXRiQXNRbWYxTEwyUWU4cGxB?=
 =?iso-2022-jp?B?TTFWUUhoQXk4NGtYWGZKbDd5N1dRbE1VT0FhYndqWVZIRXUwdzRiNnVs?=
 =?iso-2022-jp?B?WnoxYUxJdWtRbVhnZFBkL0N5UUtyUGtJNGdzK3ZPNW4wNjlRVk5RQWNG?=
 =?iso-2022-jp?B?clhyT1J3bjlLL3VPQ3Q0S0ZRMGppN05WZUZKYkYvQnJ0VUpERHE4ZEZs?=
 =?iso-2022-jp?B?b0Z5RmdrK3YwZCtYTm4yVTlEYXRZTVp3WTQ0S1BPR0cwNGpSNXo0NFdC?=
 =?iso-2022-jp?B?RG5xNjRsdlQ0V1dmT0lQOXZ3S3NpSUtnOTZicjR2ZWgrdVBMTWRTZUNB?=
 =?iso-2022-jp?B?dUNFZ1R6MXo3MlRuaG9LK25MM1o4RFFSMWJIUFREMnpham9TcUc4eGRm?=
 =?iso-2022-jp?B?dDhHNTVLRU5HTGhUandENW1WdFEySmJ3WlAwbzhtZDlYbjd6NUJMVGVl?=
 =?iso-2022-jp?B?M3NrNndQVFdpaWNSU0ljU2t4WXFicGZ6MFdqZUxzcmFsZGh5S0JvVEJE?=
 =?iso-2022-jp?B?OE52eG01cTJ0dW9LZzAxY0xSQ1ZCb2l3WVpwYXlIVmFCZ1B4WDBSV3px?=
 =?iso-2022-jp?B?ZlBvN2Jkdi9TMUlZenFhUlhVYVcwcFNtZGt6dkNuR3d6R3RpeEIvTjNZ?=
 =?iso-2022-jp?B?Ky9KWWpvYlB2cWEwTHUwRW9jelZ1UHB3OUY0Ly9SMUkwYmNpOVZ4Yk5Z?=
 =?iso-2022-jp?B?Y01uZW5XdFpWQjk4bkc4RzM4NGpaMm1NTnpXbk5jZXRYcmlIVWY2SXYy?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5502.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6905bcf3-0d1c-4899-b7a6-08d98950847a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2021 05:08:36.1813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 bAnPSZ1VAYVf0R+lfrSU7/NZbwhQ96TlGzCLUnjS6oj0hcgyTO2ZcnEMt1+i1D7sMb+swUc8CSlzSvW1xCfo2sT4MN2EQ/07j2UWvwk34gU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5401
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Oct 2021 05:08:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/6800

Hi,

In deby CI, cloning repositories from https://git.yoctoproject.org is now f=
ailing (for a development branch):
https://gitlab.com/cip-project/cip-core/deby/-/issues/15

It was working on Apr 13, 2021.
https://gitlab.com/cip-project/cip-core/deby/-/jobs/1172425075

Do Anyone know if there are any changes in certficates in the containers?

Best regards,
Kazu


