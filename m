Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A9E3C282D0
	for <webhook@archiver.kernel.org>; Fri,  7 Mar 2025 03:49:26 +0000 (UTC)
Received: from AS8PR03CU001.outbound.protection.outlook.com (AS8PR03CU001.outbound.protection.outlook.com [52.101.71.58])
 by mx.groups.io with SMTP id smtpd.web11.2062.1741287383368831829
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 10:56:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=NaGAHVVs;
 spf=pass (domain: siemens.com, ip: 52.101.71.58, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnyNJC+z2d1O5iHCe9D8R385GwXD+lYAuyhf+CZt8fB5bbzcVKlsHR5NlwUsnLzb5vIF+C9pTLsHOJo+ghxdelUVaAKB5CzLY/p8mYZ08FrLGl5anr1GRUTbIyCUK35NJfQPw9XNKiiaaemuqbME9Y8StuZtvx6CdJFqk8Juwj4ywolqbSSeghpMKkrEFEtLmfPDYFZdKzNy41uyCUGGCJMWnjAR49r2HrgGVWSckihmzhGl+MvacPESq1GgDrhChgTEHQl0iQqMXf0stkUS3xvIIj/vgWL+pVgt4izLeI5T0KMOrBrPOSnombZeKtqjSe3HiG2FjeXhuRnvcIlcDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNWv628ryQPRwtgNxTsQuOAj+xwTXZ3JKODjyvyRTTA=;
 b=Sy9AZ16jYH8K1AGYJ7QjMWPrTRhjuG0P+3B5fjD1N7Mh66Bo59Y9Zq0zMxFuNxmexX3vrx52ytNbMCa8NVNqQrGX/xWqT8m8uU4guMsEgm84BFRFPpVkV52c6GJ4GIo6MvBrjRQpiFhG+L7633OBAMH86GDgW3c51EK9L8nLFTcx2AzAylnkUJadmq28A77gtDsmmY4JbYrMCuxL8H5rkoplw+aAHRWTP1CrdmM2gTThi2Tply6OkbkTIL3lzPhWcsQKVPut9SuYAHg11rdWPdskd4aOAMuZIhGVAlUwFNMtNXIkkvRLNffm0TEAWco0KAzc/PmgGTzWAHPn2DneYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNWv628ryQPRwtgNxTsQuOAj+xwTXZ3JKODjyvyRTTA=;
 b=NaGAHVVscgqooIZYPsN/6iX3KmiJrWHmdnjBRp7ctgFmHP7vQoKvh6OGP/ZQp9c2Oqs+LP6K1psO3/P91sl6jNhVN8Ayyq55rXsbZHbkEH38+BT2nLPizCjnGQ3ISjL3b82Jbpt92J4MHHdEIYFhaymzgOR5+n2QCyuN+xTcIaAaC2n/EjNFX+zix5aKkZukxfttRBen0LMIcfZzpprMzOdlXbynVn8AWqkRvCBnuUzIPyGjpSD7MnY5HxZA8lKf1GBuPEogEjYNGqKKW2qJg77vabLM7mVVUsxcS+z46IMpvdWR1XGtVIVaOCSM8VXp7P8BDmtqkbhqxQqK/LPu/g==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by VI0PR10MB8472.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:21a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 18:56:20 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:56:20 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer provider that hooks sign-secure-image
Thread-Topic: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
Thread-Index: AQHbjns5YmpFem/SVkKzaVXtmh0o6LNmXE6AgAAX3bA=
Date: Thu, 6 Mar 2025 18:56:20 +0000
Message-ID: 
 <PRAPR10MB5422327E45FCAE49FB7734B580CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <dbdfd4e8-6aee-4c65-9bbb-8c589bcba739@siemens.com>
In-Reply-To: <dbdfd4e8-6aee-4c65-9bbb-8c589bcba739@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=3cf5b08d-009d-4f85-81ac-899f424d1b40;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-06T18:50:01Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|VI0PR10MB8472:EE_
x-ms-office365-filtering-correlation-id: fd6a37d7-85c1-4b06-107e-08dd5ce09522
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?2SYexxvV1NN6czID5oxA/XDTtGhoU5S3aIFdOt1kec45GzXxzHlh+wtnzv?=
 =?iso-8859-1?Q?iirQF9PyOn8SiXthtG7r9kztAriC4Inu66wf9Zc7glECs99ZLTaN9YTQ40?=
 =?iso-8859-1?Q?MNd48kJvC5rp7v0p7TsYw0k8eBQv273xecTda8eemov6NTIsVLcLAT8tcU?=
 =?iso-8859-1?Q?3337YyOwPj5RQog4wKbFbD4Tqchr3YujJSmCcmnXJo0OBJa/kp9jDzTAoY?=
 =?iso-8859-1?Q?a9Z2/21tvZ/1q25jJjRgDznlq6WWeWTa+6KQzOG0vwRt4GAwZzDJD1YM/s?=
 =?iso-8859-1?Q?SP5QQCUmnSr5VOphB7g4ej+Td+Sk/REoveuK2YzAGy+Un1hl52EJA57SG/?=
 =?iso-8859-1?Q?ct/U5I5jorTBgSlbGux6NUcqIiXRzuxrzuBmDp2mXj84oo/9Y46UfevICC?=
 =?iso-8859-1?Q?M1FoRLkx45P7BRDSFZiZBlM9cNWuHHRD60lOcOmbI+QNETyxUk8T3BUFlp?=
 =?iso-8859-1?Q?O9xwvNZwkNNwnmtFEE9/5vZbwHDfNGJv4OefbqRnySaTE9kpWxt9kKmKLw?=
 =?iso-8859-1?Q?hbBxnlyQ9VgPATTPHHheQ/ZDZvTfeojA9eEXHHwtZpjPqDP12nLlRDj74V?=
 =?iso-8859-1?Q?patNM5rhXIOvrFMme3fNefNKIT0CHHnHTB+H7agzV7vwvXlYeDYFDzRDzQ?=
 =?iso-8859-1?Q?zQ2NOr2ipgreL2EBBfn2yfFTScsDw6bbNopp/18ypobovBaPA7/qigDpiS?=
 =?iso-8859-1?Q?MilPdD8oGRCHVF1v6pX6x6tYD8S9gIkZxWvL5dx8d/bWzgAQtELesxwLWP?=
 =?iso-8859-1?Q?3vhx9NHnybJVLX/4+zygm7zLtYSq3nJF4BZhoUns+Jn1ZcBjzkMijaKQvx?=
 =?iso-8859-1?Q?sHXAOe7enoV9yVcyEaHTJeh1pBxKLDcg7cczluVsw6k0EqG1nj6/k2wODg?=
 =?iso-8859-1?Q?V80ZWt+6MAw1azrcF+CwZnrzfm3D8gMJB1Tf6xFej+igab5ONXqjttSEYv?=
 =?iso-8859-1?Q?ITL05KWJVwuk87sD6N7O+kqu+VkskyO72icA0s97u54JxoBHf19Qivp02u?=
 =?iso-8859-1?Q?rFM3nz2Mfwam2Tk7ZxrnAZcjMGOXL9r4MeHlTpFj/rYfFkzPjKDsaTUrJN?=
 =?iso-8859-1?Q?I3db3Y9Uh7TGrBy/q/y5sMwTh8K1LhlqRKCmV/tDEyHTytMoAT88uVHog1?=
 =?iso-8859-1?Q?pPvTMJ49SCWTmPURFwaNtSoL58DZvUwzW9DpbQTVzO1FueHRpPISCVxTbw?=
 =?iso-8859-1?Q?kEqWFwG9WR1lm/sAPW0S2XE/la5vjS6jv47AdDuVTpjciJcv4lRDgtpaf/?=
 =?iso-8859-1?Q?Muyvlp/8b+I/q0FSZeXJB52hHrkygdtGdZxhQuyPt7QPdu2uMAzId9sWm0?=
 =?iso-8859-1?Q?JgAAMOPPGMX2MoKKTu2oOdolJwFFIplOKSIFG9Lmn1bZ2wVKpBXx03+uEg?=
 =?iso-8859-1?Q?zKYj3fr/QqBXh46zzMfuAWzJTvPQzQElnUw1CuolVBQZfDkUJNQj5jqyDw?=
 =?iso-8859-1?Q?LEVkuJzMHbDXge9HhTQVx1KFdoq4xD53JnN5pbAwoZjc2YBwHEgukKY8a/?=
 =?iso-8859-1?Q?EvNUGy3H2wSLHhX7/Mk+Ia?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?sgBY4mIFhuDwUnRcO1tDU/Fa/h6Z9k+Ft1KxcOldFiepjHkxbO4n9uqMro?=
 =?iso-8859-1?Q?DcwtClOxdURlRQtZZ3dbLjVhlstvwt1pKUy+bXhN9teMaMW6CrCWKNz1/w?=
 =?iso-8859-1?Q?FnAv6HS/tYT+9DXFKd/JPsiacJl3TA4IL6XLpLYwCdgRfADNnHTrd2hPKy?=
 =?iso-8859-1?Q?QLwXYg5MfcOgNlL7XajOAfRrteAick6Sp8n70NFqXi+bzI2Sw5kSEMdy5P?=
 =?iso-8859-1?Q?YoYm+YYSuNJEiMvpPZTD+IBx5OjQ188Ey0yrvHVawknj/BTm1X/Pjr1JTs?=
 =?iso-8859-1?Q?YPQsYH/yeEDMUSb8z5NTBxgSfmg/z0hhdMSd0LzcrWwrMHjzX4YPhUlADu?=
 =?iso-8859-1?Q?SYO/EZszttPt/zsclPrTI/7bmuG+n5rkkRdOKZfqAH+C15tMaWQljKJSP5?=
 =?iso-8859-1?Q?kAt5PaIRCrbaL65M142TlZZtSgtQbBZLCQUNdKaQVRs806ugEP1JrPPzQr?=
 =?iso-8859-1?Q?mrinAooLLp8A9oy8m4jBgkrAje7ejIzPl2T3uZA34KdcKP5IKF+3GNXxH0?=
 =?iso-8859-1?Q?Uhg6J3bRX3rZOWWyCUvC6OvKhSzRNzUrHSlBI3Kc0B1YHE0A8SeYKWGHce?=
 =?iso-8859-1?Q?Bu6eHVGM6/rEM/D0B/uEHNXCsgSDdnYXStCmgNQJ8rGHhT/0/n2naYS2Yh?=
 =?iso-8859-1?Q?puFsLrOWY6Q18daXEmQ9dQ966eU21ZW8FnhyaD9ShpE+k2TNPZSm02H1sm?=
 =?iso-8859-1?Q?+ryK3oF780VanbOsswDdISogoQCOBbRgyxz47ErD3lLH01EUwse/TP4yw6?=
 =?iso-8859-1?Q?EuCvJ1DbYyu3kojZCtLZwMMgX6dXh5tJcsBbAcS42rNah5AR99DrbTKRAm?=
 =?iso-8859-1?Q?4SOSX/J4cTzyZLRJ98ygFyoro6g25GZtLHoRBIaF8JQ1CWxDA+Q9lqs0cz?=
 =?iso-8859-1?Q?mIbebpDAplgD+fv4V9wl+0lh1HNe1ToDqizJFtvsimTwCO0wnD21/p4mdM?=
 =?iso-8859-1?Q?aPAEQM8WwZyYcsCTLa/XWmDvZhwEBmZSVGdgjuoJPA9FdW/oFXGL2jsg2q?=
 =?iso-8859-1?Q?xikSfUvNw+sTsZLTl2dYbHstL49n/TWeg9Tvs/DgIYfP/jHnojL8kmxiA+?=
 =?iso-8859-1?Q?fLMbcTmJm30kvRlojYqAGTvW9UxDs8E7zZKxBTE+qsb8119Rc2SUxvJyQR?=
 =?iso-8859-1?Q?O8H7P9GOdtK78J/KV2/esb+ERvtjxbv3EPAIvTWzt7Mo3Ecbi5yzxceMdk?=
 =?iso-8859-1?Q?lNz3Yyyee7ixs7dALY6Ie6wS1W5P5IRrx8Rig4EMLRNhVcatPW8cfERqY8?=
 =?iso-8859-1?Q?POEpuOgUwKrchdsYcu1YR0ix0CSUEyhR8S9np0fFzTncX10/qAk5g+ePG5?=
 =?iso-8859-1?Q?W38/sLdQlOk2GObEvEZo3l+TWnc67LZjq1Mu7qR9WzfEy4IsGZ4lFgqfa0?=
 =?iso-8859-1?Q?OWJ8hmSFNW6aCZyYrgGpNYhv7jOPOlG+IUaU32ekeUGaaVQNhlbZbpvTIg?=
 =?iso-8859-1?Q?XlYGmnNETcugrwWj8MBMLFa2keuyCGiFWXdDgkvN/ykdZxHcwcJOSLBlKk?=
 =?iso-8859-1?Q?WxOaSs5okfui5ItnH0dyyVXNcVSuBIzrAiqRJp8rSGB/chUw64zQTTkmjF?=
 =?iso-8859-1?Q?wU9LJPwU+M7R+jsX8lhQbfeMpDLcRD07OwBiarNOzYedsGLzYb58NOVlZw?=
 =?iso-8859-1?Q?oTgD4NSv9z/GIHGoJ7Y/x34NH3vGNrytfi?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fd6a37d7-85c1-4b06-107e-08dd5ce09522
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 18:56:20.0400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2l/oIMS8H5EaOQaWYeoBDFqp/KjGao0DIPy55t3+lhvvEJmQ1aauBaZOUhtwZ80xdNjuBxAFcjiqqCi7Ll7WGsbcXmKuxaW0Z7B3PrXC7kM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8472
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Mar 2025 03:49:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18065

You are absolutely right, I had checked the signing and import sections for=
 reproducibility, but it is unfortunate that the attributes had signingTime=
 in them when they were exported. I will take it into consideration.

Thanks.
Gokhan

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>
Sent: Thursday, March 6, 2025 20:25
To: =C7etin, G=F6khan (FT D EU TR C&E) <gokhan.cetin@siemens.com>; cip-dev@=
lists.cip-project.org
Cc: Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to sign=
er provider that hooks sign-secure-image

On 06.03.25 10:35, Gokhan Cetin wrote:
> These changes split the signing process into two stages.
> In the first stage, the `sign-secure-image` script called by the
> efibootguard wic plugin now uses a hook to create a detached signature.
>
> This allows downstream layers to provide their own signer scripts in a
> similar manner for the second stage, without having to overwrite signer s=
cript or partition's source parameter.
>
> Signed-off-by: Gokhan Cetin <gokhan.cetin@siemens.com>
> ---

...

> -faketime_cmd=3D""
> -if [ -n "$SOURCE_DATE_EPOCH" ]; then
> -    faketime_cmd=3D"faketime -f \"$(TZ=3DUTC date -d @$SOURCE_DATE_EPOCH=
 +'%Y-%m-%d %H:%M:%S')\""
> -fi

You are also dropping this, breaking reproducibility (see also [1]).
Another reason to carefully refactor while providing reasons, not just repl=
ace existing code.

Jan

[1] https://github.com/rhboot/pesign/issues/125

--
Siemens AG, Foundational Technologies
Linux Expert Center

