Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30417CCF9E0
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 05:21:51 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.25385.1761542510059432508
 for <cip-dev@lists.cip-project.org>;
 Sun, 26 Oct 2025 22:21:50 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 59R5LmUP3655650; Mon, 27 Oct 2025 14:21:48 +0900
X-Iguazu-Qid: 2yAbRVlfLQuezAYVAh
X-Iguazu-QSIG: v=2; s=0; t=1761542507; q=2yAbRVlfLQuezAYVAh; m=98Jjr/y7PDpmW/90g9HMQDSOLy57g3G0a6upX27cNWk=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cw21R5YNmzyPZ; Mon, 27 Oct 2025 14:21:47 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfXVcjji5mG5r+/s8VyConAIoIEZYA1mXLH9i/KhX2kSFENNJAIPN1wQk3PID91eWgFv4B1ZnVme4xmKtTgpviX73a2v5A8XWjKzCOhe7IvQd6+tworNWIqsHLIJ3koDLUTge9PIgZNivNOF9Y4YB8DqxIEUdzHiSCvn2aITaJCVWTZViO6OpBKFwaM2MNwq1F3Gvw6RtbzaTHDlJ58IjPBR9O1Jl3rCv+h39q6rA8zIwd12aw60jEHUzpPA2z0QDq3hAYAPwlJAUOuc1wlLIrBVfXO+c0Y1EbIA7PkiegDuYbQFJiJbNRGMAytpc8wIxrjPC1sJviXs6zfLslAHKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIHMP4FwOT09hdce5WbUvNjpJElOIh6TFv1CLqNcqqw=;
 b=pKiqWQmN+ynLf3/jiXDqLXn+RBhsTnHp9vWV7Ufz4iS97TXxxZ/gUZIEBHDZQnaKHQrJb/jsj1iLv78WurADFQ5FM9T31iJg7HQglUDSTvpJVYtoahWjL2ZIj/Hz0706vC0jEF0jiGvGWAIQ7X8LS68PEu3ccc3GMKHWzmH+CM0xv4J+rAYEuemtS6eosCof6pY7IuetSAU0xnNOIn3ssAJjHUBRKeljyJm5hOY+7dcuiniSi/2GzEnCzmmyeSB79zDYlvwlXg+Ezn06sQ6LRNGnPOuD2nUgeZ66W1JJMLVxeRPIb7kK9HrBWBzQeuxVHnfVjGD3+V+peD72BP8Cfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>, <quirin.gylstorff@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
Thread-Topic: [cip-dev] [isar-cip-core][RFC v1 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05 for trixie
Thread-Index: AQHcQofrnXFr87F9i0aDfGYdXA+wbrTMjx2AgAjtMOk=
Date: Mon, 27 Oct 2025 05:21:45 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB966928ACDB11A20191951248C4FCA@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <20251021125233.1528087-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251021125233.1528087-2-Adithya.Balakumar@toshiba-tsip.com>
 <0f2a33fc-dcca-423e-a3f6-efc12a3a6d50@siemens.com>
In-Reply-To: <0f2a33fc-dcca-423e-a3f6-efc12a3a6d50@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB8293:EE_
x-ms-office365-filtering-correlation-id: 813f5c90-b1e6-4418-2da4-08de1518b8a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700021|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?b2Z3KzdTRWhlQlBadlVHVW92ZUZKYUxDTWE5T2dpTEZib3FBd1JVN0Rx?=
 =?iso-2022-jp?B?dVJsKzhWczg5WmF0UFJtL2pjMTRaS0thUlphNFFXUjRzY2ZlUlVacktr?=
 =?iso-2022-jp?B?eDJTVEp1bUg4S2dYZGlsVWFzOTllcWh6M08zeFlnc2x1QjNobUdzRFVG?=
 =?iso-2022-jp?B?Vnc5a2tVYnd1Y2JBVUpqeHU1TEI1YzR1U0Uxc0p0TFZsc29UNUFaRjJu?=
 =?iso-2022-jp?B?ZGhKQUh4NkNTYWFIS3V4MzFobWlyTWdKQXhXZzJKQXlBWm9XNXdBb3NR?=
 =?iso-2022-jp?B?MnVFcXVFdHcybnByQi95Y0hpWHo1UEpiUE5pb20wbkRyM3p6SVNXcVRr?=
 =?iso-2022-jp?B?R1NyNWZ5MTZKbWhDMW1rbjNPSnkveVFOaWtmMnZETUxaOGN1azZ2S1pB?=
 =?iso-2022-jp?B?encvZ0FaeXFWY0NWeVl3Z0YzN3lQem4vL05JVVdEYkllbStnS0U3WTFR?=
 =?iso-2022-jp?B?VlA5YXg5UUMvK1ZGVVdhUXNLOU4xOXVzYTZHUFRpMEFMS2JQYnhydzh2?=
 =?iso-2022-jp?B?RlN5cnM1eE1QNmpXZFJUNEM2K1FYUkNwaEk1QitxZXlESXNac2ZGdlN6?=
 =?iso-2022-jp?B?bDJIYWpHWmtzWmIyUmtlRm1HMWc5RXBpOGdsZ0hZcHdPQTZnWmFXTW5U?=
 =?iso-2022-jp?B?V2JwYzg1UkRRWmdSeFRoZEJoT0p3ckp4blh2aHNrWmY4bUdUQVErS3hu?=
 =?iso-2022-jp?B?MGt6VjViaS9PYXdzVk5uOWhWY2R0SFNhUjd0dHNrS3EvaGdqckllUnNK?=
 =?iso-2022-jp?B?NFR0Uy9Ic2p3M2lnelN6dGZ3emdNVVo0U0tLMnVjNE9ndFhVTDV5em9M?=
 =?iso-2022-jp?B?T1RkaktGbEZOWk5rRFZUUFc1N1JrVUxoV1FsRzFEWDJKSEQrRVZhV1VE?=
 =?iso-2022-jp?B?WVE0anJRU2Y1QXBLbHU3dDljWnNZczAwdGpNVERqdlp0dEhTcks1RU5W?=
 =?iso-2022-jp?B?VHd6cUo0bmZManBHdU90d1c2RXhoWW1iaHFQakRQWHZPSzI3Q1FFaEE1?=
 =?iso-2022-jp?B?MG54MlphVnh4RjJoY0xCU21iMUFQeHF2d1d2TXlaU3ZENzJtK1R4OHZJ?=
 =?iso-2022-jp?B?VjNybFM0SkdHRGE2aTkzSHVQbjNQaHJQbCtBN1F6MmwrU3hHTnVma0JH?=
 =?iso-2022-jp?B?NTZDaytMRVY2ZTh1eFpMUVdUWGw2Q0IwdHNGL09nKzBOSG9pNXMvMzlQ?=
 =?iso-2022-jp?B?R1MvMXFaUmh2Ti81cEtmTmM1TDA5RmNFKzRqNFhUOTdCRXVzRVpyUW5V?=
 =?iso-2022-jp?B?TU9hcU5JWStoR3l2NXN0MnJQTWRvK29BeDNUWS96SGJjYzNjK1VMdlZF?=
 =?iso-2022-jp?B?Z1FrWkFkenlNbU1QOWVXU0xCQVZ3RzlROXkwWTdZRlBraUZpbFBqT0ZH?=
 =?iso-2022-jp?B?R0ltRVR0ZDFPUTFPNUpERGZiYmVVakVvblBXUmY3ZzhwR3RFS0ZiTm0w?=
 =?iso-2022-jp?B?OTlncHQwdDRSSFNNYzlocGZic0s4YUc0Vk04UVNReGxUZkpSOGJQaThY?=
 =?iso-2022-jp?B?TTY2VVJkMnZtSEoreGMrRGl2UkhXMW00U3RCYkl4YlFyY2pVWndlaHVD?=
 =?iso-2022-jp?B?dWkweXdnSDlab1VDdFpHVzhaVSsyRlpna1RNNUxQd1pHMForeE9YTXJL?=
 =?iso-2022-jp?B?cEZDZlcweENVNEFEZE5TcjAyTzl5WGFPZzNSNCs2ZzIzdDRDSE5MT2ta?=
 =?iso-2022-jp?B?Z1ZxOEZnRGZyU0krRXhMT2pDTzVaK05DN2ljdENjaU9kTEcwbzRrWng0?=
 =?iso-2022-jp?B?ekFLSnkzNG8wbWxlYjA5dDR1ZTQ4YmVQb0J6T1V1dFUxV0xCUzFDSVQ5?=
 =?iso-2022-jp?B?ZGRWN1hOS1l2MnVNS0YzV2hRb092N3g1Rm93L3ErYTZoa1ByaG80em53?=
 =?iso-2022-jp?B?TFhFcVdrQSt5M0JZR24vSDQ4NjMwOHNYZGxuWHpYTEVOeVEzd1lkS2hD?=
 =?iso-2022-jp?B?dkNIbzU4cTdRcTE2UTMzQitaK1FFK3UwYjM1NE51ZU96NXhIeUN2eGty?=
 =?iso-2022-jp?B?bTJPTWt0b1loUmQwc085V3dKOEtzakttUWI3VWhkOHE3N01jczdvblJL?=
 =?iso-2022-jp?B?SzZhWkFkMTFoaHBqbmFicXpTaE9mczJVOXdlNE9tRW9DRCtOZXV2Y0JS?=
 =?iso-2022-jp?B?RnNueGQzemVlSU1GT0VXWWx3WXdLdFBaNUhpV2NPZGlUMHY1alNzdTZk?=
 =?iso-2022-jp?B?N1JOYkRjK2VYdlFjT0M1aFhTdU9tNEkvdTkydlRJTVZ6T3hqRzZCL0Z5?=
 =?iso-2022-jp?B?NDZRTHpxUnRweEU4TmQ0UnowTS9rY3laST0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?bEU3M2ZLdWM4QjFPaUJaNzhZNk5SeHpJbVBHWGxwYTAvdmtmc002NHR5?=
 =?iso-2022-jp?B?ZlphUnZZakxNcGQrZUVUbTZQaThKTFQ5ZllMSkdnYmZTNTdZWDNDZjgr?=
 =?iso-2022-jp?B?VmJvSFl4Y3lsanpRU1VuaFpmMmZaclRTNHFTajV2NGhJNWkzeHZ3TW1s?=
 =?iso-2022-jp?B?QStubFFJTkNKcTNEa2tVV00yMnlwTWx5dGo5eE4yWmhJeHA1aGQwV3Fq?=
 =?iso-2022-jp?B?QXJOVndxbjl2UEFaUEdnM21iazZNQm5YRlVkTUhITDNXMnNlVCs1dmNi?=
 =?iso-2022-jp?B?WXQ3aFN0UHovc1Q4bnIvd3ZGbkZ3ZnlCTGh0UlB5cnprNVBaOE9JVFdQ?=
 =?iso-2022-jp?B?VEl2N0FPMmJiLzJRZk1aMTZOWHpiS1NXUWt1bWJQaDRpU0Q2YmZoUUhQ?=
 =?iso-2022-jp?B?R1NmUXpxaDlWVnBDTmU5eXRNL1A2WUJWUVBkR2ZFWmxMUHk5MWtLdStC?=
 =?iso-2022-jp?B?RUJRWUhhcnExVFB2MktKMlJ4QkkzL3NEd2V2cmJqRXdYTGhiRjdDR21D?=
 =?iso-2022-jp?B?eFdyS20rZkwwdVNFcGtRbmZYbmFRdVVnWU5wSUtHN1ZjUDN4VTBzSkI3?=
 =?iso-2022-jp?B?ZzNqV2txem9CTE9VeGFNRTBNSkZyc2cxcmZuc2VuY3F1QnVaYWhqWmJH?=
 =?iso-2022-jp?B?bytWbytTbklwS3c5cDlCK3JpQTg1MURmb29yTVlrUTZ0UnlHaUFTbk5N?=
 =?iso-2022-jp?B?dkdHRHFPNVVEcERSTEhJaExuV0hwd255YW9UVVVSellNdmVvRVRGd2U5?=
 =?iso-2022-jp?B?T2VYa0tXVmR4UUl1VGJYbXZGREJrWXNIWExLK3FOcTA1cU9RMEViczlV?=
 =?iso-2022-jp?B?Y0QxbkNRL0lsb1NPWjI1YmZSajhZU0tyTEpGL0hSaHNjZzc3K3NMb1c1?=
 =?iso-2022-jp?B?VkNHVTJYcUw2eHg4YUIveU05N3d4UWRVNnQzb2x2ZkN2UmxJMXJxeDFT?=
 =?iso-2022-jp?B?QTlRZ2JHRCtaTWlITndhcHVzNE9zZE1pMlFMM1BzdXgwanNxZTFXS1BR?=
 =?iso-2022-jp?B?WW5saWJzSGExQTJFVDV1ZXlwUkdDMXIzc0lvMEJGNTFpNVl2cWNrQ1lY?=
 =?iso-2022-jp?B?MHlOYmpsZHB2UHh1L2tDeG1ienhwRjFoMGtjTTZxOGtWNFkxZTkwRDJO?=
 =?iso-2022-jp?B?ZExFVVhpQTNSek1wWm5pZ0FVRjkvNzFaZFI4RjRraVg5VDRJWXg1TDIw?=
 =?iso-2022-jp?B?Q25oWldpcW9jTFU0S0FLd3JKSjlQbkl1OStoaEc4NUtjK3NqMXRiYmsw?=
 =?iso-2022-jp?B?T3FEVUYrR3RwcEJpRFpKRDRRTlY4bjhoazNkSERVVnZ3WkpwS3c3di9w?=
 =?iso-2022-jp?B?S2REMy9DYktSNDRYYmg3MzBFMUNscnNyVjBSQml4SEpBK1p0MW9BWEtj?=
 =?iso-2022-jp?B?K0x1VUszUHpGeEVnR3A0WTM4aFJrVTBINFIvZ0tMVXlXbUxNNDVhbkNQ?=
 =?iso-2022-jp?B?MTZCT3BJZFpXNEp2T0VhQ2Uzby9qYzlRTnpqcGRjL3pQK2xVVzhBQnh1?=
 =?iso-2022-jp?B?ZXNQeG9tcG9aaDQ2dUp2ZndtYzlIL0hjOFpTWElpcFFYcmlrRlJmbkpG?=
 =?iso-2022-jp?B?Ylc3SVE3clJjaUZTekdHa2lsb2dkTVBYK0pjOE9McktwUFdsQXA1d0wx?=
 =?iso-2022-jp?B?SGV0dDJjWjBvQk5wTFpJdlVxbSs5WG1hQVpWR0hWQUw5R3JGOTVwUmlN?=
 =?iso-2022-jp?B?Ylg4U2ZkK0IzQnRWNUFZR1E4T0dBY2xKTG5vOVc2aXphUkg3RHd4Q3V6?=
 =?iso-2022-jp?B?dnlhUS8rQ2hkanNPWU54dithZHplTjYxemlwYnZIbEg1S3hUbVhJL3lF?=
 =?iso-2022-jp?B?WlptQ0N6ZVlUODBmL2pweU1WL3pRMGdkWndlNnFjRnBPZVU0MENWNW1q?=
 =?iso-2022-jp?B?a0diQmFKcHlaajgzRHJqaWFVMXVZRExkSkMvRzZnTWdnUmU0ejRpL2xq?=
 =?iso-2022-jp?B?bGJCZ2F2V3NYOEI1anhjOFNoNGIyYWNZc0lXTnNCWm5CTFh3dFYvZmo2?=
 =?iso-2022-jp?B?ZjhiNWtocUxZeTIwLzVTV1M0NHI1ZFFib3M1QnpuRldDa1hoOTBORkFy?=
 =?iso-2022-jp?B?TmhQdW92RTc4ZUpSTUNuOFpaWlZTaTd5L2NMVGkyckZKeW5aa0tmelYy?=
 =?iso-2022-jp?B?aGdxYk9jamFOYzlaUlhHQ09Ea0FhYXNjbWV1WEVxTE5yTURucUdoU1NS?=
 =?iso-2022-jp?B?ZmdCV01KanpsSGQ1dWMxbEg2QUI4b0NWeklmbXAyV1BhQjdpYnE5WjZw?=
 =?iso-2022-jp?B?QXRXcnE1bWZvem9zeEQxUjlYeUllNTNYN2hnWXdDcWF4bmNxSVN1SjFh?=
 =?iso-2022-jp?B?OWhGVjRzNWoreGFBQUlFUmgvOE5zcHc4S0E9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813f5c90-b1e6-4418-2da4-08de1518b8a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2025 05:21:45.3367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: STq92U381xzqLSE7mfV0n5DRnZ+l+ljRMLBgKY6oOs6jFS5ng5lKN2erQOfg0akZixxUlDrC/D0tkl2u4HDODXZ1959OtMiWqIhpSG5bb/OKw9LwnK0u6fEfCLXfJgNE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8293
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Oct 2025 05:21:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20220

Hi Quirin,=0A=
=0A=
>I would discuss this fix with Debian upstream instead of fixing it in=0A=
>CIP with a new SWUpdate version. As we need to maintain this version=0A=
>even after debian no longer supports it.=0A=
=0A=
Thanks for the feedback. As it turns out, the fix is backported to debian S=
WUpdate 2025.05+dfsg-3 [1] but not to trixie stable (probably because it's =
not a security issue I guess). This should help with not carrying the patch=
 locally.=0A=
Would it be alright to build SWUpdate 2025.05+dfsg-3 from source? Or do we =
want to avoid building packages from source entirely?=0A=
=0A=
[1] https://salsa.debian.org/debian/swupdate/-/commits/debian/2025.05+dfsg-=
3?ref_type=3Dtags=0A=
=0A=
Best Regards,=0A=
Adithya Balakumar=


