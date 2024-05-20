Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F78C04FFE
	for <webhook@archiver.kernel.org>; Mon, 20 May 2024 10:23:05 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.56925.1716200575553028099
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 May 2024 03:22:56 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 44KAMrlc3729650; Mon, 20 May 2024 19:22:53 +0900
X-Iguazu-Qid: 2rWhGbqYikiuxRTlFw
X-Iguazu-QSIG: v=2; s=0; t=1716200573; q=2rWhGbqYikiuxRTlFw; m=FQyOIow4gA7Vuszm8HpvTGZ3j7azRqvvVr08rEmRCpo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 44KAMpTu1411487
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 19:22:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE7JNkDcsC21b3Al44/jy77oZWh748YB6pdKQm4DtmVGPZ02huJGFYjsAr5mw765gUzKPit498W4QoGOlDGd/fBc+szJnN9Ie/EVGvHVzbfQDI31zYV/bdXu0EpM36rT3GKdRKvsc2RCHifc2JLJtvYouUfwOvhLnC3odmaA17PZacwLerTGpR8qP5rcDqqf2crl667veCKjDwiG27EuEyuwQjixc6FpHLwIai4XvfxMqpM7SACYdKF0pJz1zpcbJNt4OSCzzfQ57r7YQbBP2LcKWlj1gyIzi1k2aG/CEvw1O9mxCJLh3VzbMq3YQgJEoUinNAkF5DKVh8RvK6IwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lleb1O3Eemm1AFdD/z6S52Ir04KWFXrxuCK0Ir9alY8=;
 b=CdmSXW63u4KKLu5YfLed7EJROGJ7KNFnHmyYrAEOEYLv2zvaQg+YypqXqP9+2GID16vvVJsabKrlHqbQgA35Y9X+hjeJ8Dq7AnjS9n6VvN/srS7b1QMoizcpHDXpuFEW14jxYhcOSHkGv3qIJseLPbsr1oHJNHy2sstb+NNTyuvscswJaV+SEkEcOhN+Vkl0IkHCVnBn3cZ4ysOCvzCeRFBWTdboIn+m5MTrBUuY4/5xvJvNymSxaqWH5PBnE/2sOp35YJbE1GyEOLrjKqDC3yS69ppKdgRAfevRy+mUQMPDHK9w/W6olIRYb0GqZzk5PmpPxJB5QLQE18nOlLMKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <dinesh.kumar@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBw
Date: Mon, 20 May 2024 10:22:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|OSZPR01MB8356:EE_
x-ms-office365-filtering-correlation-id: 0ba37e48-4cb9-42bd-296e-08dc78b6cce1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?RkRoN2J2R1poeGNkVjQ0bHBUOEhBZnVRdWU3b0QwakY0b1F0aGRmYk0x?=
 =?iso-2022-jp?B?NjRwc1k1aFJoRFFHdmZMNVdRb0U2a1NweWZtM1owUEMyTGZxUHFxQm4v?=
 =?iso-2022-jp?B?ZGp5dC85Y3FiWHVmZGxBeDJKTlNqT0xldTNIWlp1cGx6UWdkV011d0hh?=
 =?iso-2022-jp?B?eGVQWnNKdHUyUHBqL1ZXV2pUTldSd1JRNGdGZG9WNFovTjhIMUJVc1Av?=
 =?iso-2022-jp?B?TFh5VmVGY2x3Z3I0YnBVU3gycmN1bDFVTUwzZHN5NG43bUExVi9ldVFB?=
 =?iso-2022-jp?B?WnY0V0RuZ2hlemNVWXVyNkNHMURCQnlnU3Q0ckM4d1hobE4zVGdsWmsx?=
 =?iso-2022-jp?B?TTRGendsMWhQOVYzTDlWV09wZ241K1cwRmpBaktlQjZVTDJLL3N2L0Fv?=
 =?iso-2022-jp?B?RDVwaHZnQWRaNXVyQnErNTFjOWVXQ29sOUxKOGRNT1ZOYUJPS3hRMkFW?=
 =?iso-2022-jp?B?WTFOZWF5STIzTDh1MS9DN0h0QTFYbk80eWZOd01SZmFFT25rakpWemxx?=
 =?iso-2022-jp?B?UlpsM2N1NStiak82ZFZlc21TYm9hbnYvaCsraHNWdDdmc2wxOHBuOXpU?=
 =?iso-2022-jp?B?SU5qbExEVDhSU2p4ZzFqZWdiQnRpOVZ5UDB3TlovUFFNZEJsVFIvVnRY?=
 =?iso-2022-jp?B?WkJNSktaRTMyK1NLQmlZNEh0dXBpclFLVFNZdzhRbEZ3V0FLZndPWldv?=
 =?iso-2022-jp?B?RWg4d3dFdTIwdTRHeUY5SFllQkJRQ1ZYQWxUVHVFakdmL2VEa1Y0ekQ5?=
 =?iso-2022-jp?B?MnVsb2hFS3ZMaVV1SWZ3L1ZHM0FXQXJwNDdWaEx3YXBzYXJjaFl5aUFo?=
 =?iso-2022-jp?B?TE5SUDdDcWRDTmFneE52ZGNIdjZkWS9waFZkQ1pNR2NpRG9MRlA1L3o4?=
 =?iso-2022-jp?B?ZmgvcWNmZkpwRlM3elA0cTlLNDVFUjZqZkVsRzFGeDcxdlR0S0ZTdkh2?=
 =?iso-2022-jp?B?RlIwSEZxM0pNZEpvdG1Jb2d3RUg1cWkzcTNrTS8wb0dQbXQ1eXFlcHJ3?=
 =?iso-2022-jp?B?RFBzUGNNam5KYVMrQis0Yk9XUG01K1pINDZuZXVEUVFENG5JTDkzMmNt?=
 =?iso-2022-jp?B?elFScmNSbHZRbStJb3FzbjZZT0cyanFsRVkxdUFOcEMyMG1lOGtLV0xa?=
 =?iso-2022-jp?B?QVV4ZEpLdWlEdDJMT2I1SE9HQVk2dFh0YXBoMkFydnF1ZGVjWjl0bEtW?=
 =?iso-2022-jp?B?WFZpeGRmY01QRS9GMWNKMU9iYkpuQjFJQTVxRm1ENnFYdTNTR05IcXJS?=
 =?iso-2022-jp?B?UU5BR0VaRmZVUjh0K2grcElISllZQjRpck5YWnpwWmREYjJOV1B0RzJq?=
 =?iso-2022-jp?B?bFRqUkxMaU9yMGJmMzZEZXM0VFdyMG1FMGtMSFZCQzU4aURQZjVKOTIv?=
 =?iso-2022-jp?B?c1RCUDRnT1poOFQ0RE5ZdzZPTTROOUZPUEhUNU50UVZueW9jMzNxTUdr?=
 =?iso-2022-jp?B?VHZYYXkyZ2JPdm1oTU5BdW95cHliV0RTUVVVVSszWTZvUlJ6R3hoRk90?=
 =?iso-2022-jp?B?dlhSWUdETVNLVk5tTEhZeXZCMlcrMkFxK2JTZHRPWUVLWGI0QWJ3N1lK?=
 =?iso-2022-jp?B?bkJMc09RV0VBU2RYMVZPbWY4MS9YL29leE9DUXdwb2hxcUNkZ3ZJV1JE?=
 =?iso-2022-jp?B?aVBzYnA1cUlYQ0twZC9TdHJxSHBENEplb3FEZ1QzNzlWRG1SY0JNSGxJ?=
 =?iso-2022-jp?B?TnNkd3Ivd3F1OFNuRHZnRVRKYWtTK2krSlZpTmhKU2FseVAzREcyRnZC?=
 =?iso-2022-jp?B?YlJjSmlzTGpqNVY3M1dHVEpQeTNWMkJHaTFTTVROY0lhZnFGUVV3RlFB?=
 =?iso-2022-jp?B?UU5PNWlSckpmek40RjhPaEJYTXBpdHZCemhNQ3dhT3pzaTRXOFpaQ3dn?=
 =?iso-2022-jp?B?PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c0tkSVN5cWNmbjcyRjVGQWV1YXN6SGMvaGE0UksvUzlTTlVIeDB1cWhZ?=
 =?iso-2022-jp?B?YUlhenExdHBzWStoTlN2U1RRUk01cGpDc2JBMFRma3JWY3ZWT2xvQ0RD?=
 =?iso-2022-jp?B?ZkVyZitkSFRod2d5K0xPY2JKeEZyTUtzNm4rZWZnODlaQ01hRFByS1Jy?=
 =?iso-2022-jp?B?L1I1RkUzYmNPemE4QkF0cUtRaWZYQm44SUNiUVBqWlM3Mi9ESzJpb1pS?=
 =?iso-2022-jp?B?dWlGdlRPRjY4bG1UWkNtY3Z4eUt4V3pmVW1BZEwrV1BCMEtRcHExcGRU?=
 =?iso-2022-jp?B?Y3lpWXZJT28ycmh0MXlIS1crdzlpcXRUbHBlMDEyRmR2dlFvQXFsUS9h?=
 =?iso-2022-jp?B?cTZ3b2w5T2x4K2JjdXNKTHJXWjlqM1oxa3FmS3lFUmdWU1NKLzhnNzdx?=
 =?iso-2022-jp?B?VjJUSGFtSklMRmhYNnJzZEZzcXF4ZWlHMDlsWWVQeU9IV0ZYaFlKcHFr?=
 =?iso-2022-jp?B?ZVZVRm83aXRac1hqSEYyY00yTkk2a1g1cERsRmRTU2N0ZFhlRlY5VW8x?=
 =?iso-2022-jp?B?cUJJUW5WRUh3MDJob0NIZFBmam5QMjRMM1V1eWJielZ1QkYxdFVrSnE5?=
 =?iso-2022-jp?B?Ti85UldJN1l0TnZIeUQ2VGZuNlRKenVRSGRVY1JUUFJpZUVOSkdMeGIy?=
 =?iso-2022-jp?B?eDltaVJyMUFJREhZZ1BtSzlrSS8zckdrSlB4MTZHazBkS1gxUTcyVGxF?=
 =?iso-2022-jp?B?NmordGNhWXEyaHBIemFJdFV1UVVOemRjVU0zMkZmOVV3Z2NQdGtteVJJ?=
 =?iso-2022-jp?B?SHhrN3YvRjFoM1VWSWxYU2t2Mzd1MjFlTHU4ck1QL3p2bkFUV28vZ2JD?=
 =?iso-2022-jp?B?RXVnWmgydVB0Z3NwdEVhSE9lU2tSSXVGOGU1VmZRVENQKzJLVCtuYWJM?=
 =?iso-2022-jp?B?d0FNY2tNZHRSN0JYYnRiRkVRY2xyN3dEWllJN3JXbFlZVWhyY3liU25Z?=
 =?iso-2022-jp?B?eUdzSjlRTnZvNDNraVVxVHpaSHQ3anBCN0N3eEVkWWVQSUJkQy9jeVRu?=
 =?iso-2022-jp?B?UWRQOUJvUmUwOXJzL0JCQmw2OWJheFNjeXVrSmFvQ2NVaVR1NXQ0U0lR?=
 =?iso-2022-jp?B?clRZUld2VzFCUks3MTJpOUZTcjN1VnZPRW91WkphdFMxRWRFSHVMSFd4?=
 =?iso-2022-jp?B?cnBRU2tNbkdlejVPNVRvb1RNOGNkTVVZbTRGL08rUXQxelM5cFlyRVFX?=
 =?iso-2022-jp?B?MHl6QTJXRC85Z1QxbmY1K2Z3aVoxQ21sQXh3d2o5cS9lUkpHK3NOKzFV?=
 =?iso-2022-jp?B?T1NtWUgyZzlUMFJ6QjNpK202d1ZPNndtOXJLUUtnbTZVTU8rcmJsZDZz?=
 =?iso-2022-jp?B?TTdJclVEK2drWWNQNGphbnNOUmFpeDJiaUdiLzYrM1YvNVpwQzlWd1RL?=
 =?iso-2022-jp?B?ZGV3LzNpWTNFbHd0a0g3ZWVEMk9BMmxIbjJ3Q2x4OWxaZVFsYkNzR1dn?=
 =?iso-2022-jp?B?cUx4eVVIVVhIR2FZaUZSSzUrWDh3TGx3V2VEOFdXVTJBOGdLQktWQ3BB?=
 =?iso-2022-jp?B?NEVSK3BlSzY2QmY3Rk01ekVHbWl3dGxxcDJ6K09KUmFTWWthMGxjRnEy?=
 =?iso-2022-jp?B?djN3YjRGQjg3WFF4SXpYSU5BTlFWWVYwN2NYOWZPaDlCMUUveDNBU1VJ?=
 =?iso-2022-jp?B?YUdvQnpYdzB2TUtweUFLek5lMnRRcFBsRUNjWWRLN283U1Zzek9vczlw?=
 =?iso-2022-jp?B?RTYvMlpGbWVOeEFLTzltZGtwNVNzZlRqRS82VFNYQTRQWGFNKzEwcGVr?=
 =?iso-2022-jp?B?ekpMdDlxcFZHOXlaMWVweUZUdEVNUUdmMnAwRm9NRFJCSXBIaERqN2Iv?=
 =?iso-2022-jp?B?cWFvSXJuQ1hDeGVwMi9rZVBIeWlxSWJ6dWl2TDd2Vk1UTCsvYWd6WXdn?=
 =?iso-2022-jp?B?VzVFeXdTdk5Cb3ByNkhZMWlhRGlxOEdzb2FQbzNpUFpzQlRCbDFoTjV1?=
 =?iso-2022-jp?B?aXNKTWt3aitzUlMxZ1RmemRvQTFYUFlkeG1JYTg3ZGd6d0ZVRUlYQW9r?=
 =?iso-2022-jp?B?VU5CQzU3Z0JaRElnOTFWWkpWV1ozQ0VMTVIveE9iWkZJUG4wYnhySUdm?=
 =?iso-2022-jp?B?SGxoYm5tMFloNE1aakFqZXpkTWcrNnNUTGZORU9waC83VnlNcFBCTGQy?=
 =?iso-2022-jp?B?bkxJdTg0cVQyUFJ0TnplaGd2K1UzRW9kWWlyOThBMzFTbXVxT2tiZFEv?=
 =?iso-2022-jp?B?VDFVWjlyRUd3TmpBRUpKNkhYTG4wM1l4di9vM1NKdDFzN2MzQW05RkFr?=
 =?iso-2022-jp?B?ejdZVHdHSE5kUkVjOGFFT0E4bDczaWppZFZoY3N0WHIzd3Z1dExQQjlY?=
 =?iso-2022-jp?B?bVpGZUt2K0x5anZzbGpmVXF0b0xkTEtqSGc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103F00964E26A0F5D38A8ECC2E92OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ba37e48-4cb9-42bd-296e-08dc78b6cce1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2024 10:22:49.5823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n7P6YnOwnGiy3wXhYscKi14vihOp864qFelbTjX7IMJXvsY3PpwXlk9SUE8IvRWX8jWERkBeVICAqXXdkZ1BY0N15TznA5ZmUuVNLoh09+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8356
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 May 2024 10:23:05 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15918

--_000_OS3PR01MB6103F00964E26A0F5D38A8ECC2E92OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Any updates on 2nd and 3rd requests I made in the below mail ?

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Wednesday, May 15, 2024 4:41 PM
To: Chris Paterson <Chris.Paterson2@renesas.com>
Cc: cip-dev@lists.cip-project.org; dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC OD=
G Porting) <dinesh.kumar@toshiba-tsip.com>; hayashi kazuhiro(=1B$BNS=1B(B =
=1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhi=
ro3.hayashi@toshiba.co.jp>
Subject: Request for updating device dictionaries

Hello Chris,

Hope you are doing well.

Sorry to disturb you with these extra things I need on CIP LAVA Lab. Let me=
 consolidate my requests in this mail.

I am preparing a patch to trigger LAVA job definitions from isar-cip-core. =
Currently I am working on that in a custom branch. Before sending that patc=
h, I have created an MR to update the cip-core-ci repository which is requi=
red to run the test jobs in isar-cip-core. I will assign it for your review=
 soon.

I will be able to send the patch to add test jobs in isar-cip-core once the=
 below mentioned things are done.

  1.  This MR needs to merge build-bookworm.Dockerfile: Include lava.sh and=
 templates in the docker image. (!3) * Merge requests * cip-playground / ci=
p-core-ci * GitLab<https://gitlab.com/cip-playground/cip-core-ci/-/merge_re=
quests/3> which I shall assign to you soon after some internal review.
  2.  I need some variables in isar-cip-core CI/CD setting section like LAV=
A_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the privilege =
to do that. I will mail them to you personally. Please hide them in isar-ci=
p-core Gitlab CI/CD section so that I can use them while running lava.sh sc=
ript.
  3.  Since we need to run these LAVA jobs when pipelines are triggered in =
isar-cip-core, I am making changes in such a way that pipeline keeps runnin=
g until all the jobs are done and we report the health as a result. It will=
 take around 120 mins to run all the jobs. We have only device (qemu-renesa=
-01) under lab-cip-renesas. So, I request you to please add the swtpm devic=
e dictionary changes and swtpm-jobs tag to only one QEMU device in every LA=
VA lab you can access. By this will be able to reduce the pipeline run-time=
 due to simultaneous runs.

It will be very helpful if you provide your support with the above-mentione=
d items.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)

--_000_OS3PR01MB6103F00964E26A0F5D38A8ECC2E92OS3PR01MB6103jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:"\@MS PGothic";}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:JA;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:121505422;
	mso-list-template-ids:1852854514;}
@list l1
	{mso-list-id:1959749534;
	mso-list-type:hybrid;
	mso-list-template-ids:-1796337264 67698703 -1 -1 -1 -1 -1 -1 -1 -1;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.25in;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:1.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level3
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level4
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:2.75in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level5
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.25in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level6
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:3.75in;
	text-indent:-.25in;
	font-family:Wingdings;}
@list l1:level7
	{mso-level-number-format:bullet;
	mso-level-text:\F0B7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.25in;
	text-indent:-.25in;
	font-family:Symbol;}
@list l1:level8
	{mso-level-number-format:bullet;
	mso-level-text:o;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:4.75in;
	text-indent:-.25in;
	font-family:"Courier New";}
@list l1:level9
	{mso-level-number-format:bullet;
	mso-level-text:\F0A7;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:5.25in;
	text-indent:-.25in;
	font-family:Wingdings;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Any updat=
es on 2<sup>nd</sup> and 3<sup>rd</sup> requests I made in the below mail ?=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th Sathujoda (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-family:&quot;Calibri&quot;,sa=
ns-serif;mso-ligatures:none">From:</span></b><span style=3D"font-family:&qu=
ot;Calibri&quot;,sans-serif;mso-ligatures:none"> ashrith sai(</span><span l=
ang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligat=
ures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibr=
i&quot;,sans-serif;mso-ligatures:none">)
<br>
<b>Sent:</b> Wednesday, May 15, 2024 4:41 PM<br>
<b>To:</b> Chris Paterson &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> cip-dev@lists.cip-project.org; dinesh kumar(</span><span lang=3D=
"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:n=
one">=1B$B#T#S#I#P=1B(B</span><span style=3D"font-family:&quot;Calibri&quot=
;,sans-serif;mso-ligatures:none"> TMIEC ODG Porting) &lt;dinesh.kumar@toshi=
ba-tsip.com&gt;;
 hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PG=
othic&quot;,sans-serif;mso-ligatures:none">=1B$BNS=1B(B</span><span lang=3D=
"JA" style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none=
">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$BOB9(=1B(B</span><span lang=3D"JA" style=3D"fo=
nt-family:&quot;Calibri&quot;,sans-serif;mso-ligatures:none">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none">=1B$B#D#M#E=1B(B</span><span style=3D"font-family:=
&quot;Calibri&quot;,sans-serif;mso-ligatures:none"> =1B$B!{=1B(B</span><spa=
n lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-li=
gatures:none">=1B$B#D#I#G=1B(B</span><span style=3D"font-family:&quot;Calib=
ri&quot;,sans-serif;mso-ligatures:none">=1B$B""=1B(B</span><span lang=3D"JA=
" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none=
">=1B$B#M#P#S=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,san=
s-serif;mso-ligatures:none">=1B$B!{=1B(B</span><span lang=3D"JA" style=3D"f=
ont-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none">=1B$B#M#P#=
4=1B(B</span><span style=3D"font-family:&quot;Calibri&quot;,sans-serif;mso-=
ligatures:none">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> Request for updating device dictionaries<o:p></o:p></span><=
/p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hello Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Hope you are doing well.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Sorry to disturb you with these extra things I need =
on CIP LAVA Lab. Let me consolidate my requests in this mail.<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am preparing a patch to trigger LAVA job definitio=
ns from isar-cip-core. Currently I am working on that in a custom branch. B=
efore sending that patch, I have created an MR to update the cip-core-ci re=
pository which is required to run
 the test jobs in isar-cip-core. I will assign it for your review soon.<o:p=
></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:.25in"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I will be able to send the patch to add test jobs in=
 isar-cip-core once the below mentioned things are done.
<o:p></o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:.75in;mso-list:l1 level=
1 lfo3">This MR needs to merge
<a href=3D"https://gitlab.com/cip-playground/cip-core-ci/-/merge_requests/3=
">build-bookworm.Dockerfile: Include lava.sh and templates in the docker im=
age. (!3) &middot; Merge requests &middot; cip-playground / cip-core-ci &mi=
ddot; GitLab</a> which I shall assign to you soon after
 some internal review.<o:p></o:p></li><li class=3D"MsoListParagraph" style=
=3D"margin-left:.75in;mso-list:l1 level1 lfo3">I need some variables in isa=
r-cip-core CI/CD setting section like LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN=
. We don=1B$B!G=1B(Bt have the privilege to do that. I will mail them to yo=
u personally.
 Please hide them in isar-cip-core Gitlab CI/CD section so that I can use t=
hem while running lava.sh script.<o:p></o:p></li><li class=3D"MsoListParagr=
aph" style=3D"margin-left:.75in;mso-list:l1 level1 lfo3">Since we need to r=
un these LAVA jobs when pipelines are triggered in isar-cip-core, I am maki=
ng changes in such a way that pipeline keeps running until all the jobs are=
 done and
 we report the health as a result. It will take around 120 mins to run all =
the jobs. We have only device (qemu-renesa-01) under lab-cip-renesas. So, I=
 request you to please add the swtpm device dictionary changes and
<b>swtpm-jobs</b> tag to <b><i>only one</i></b> QEMU device in every LAVA l=
ab you can access. By this will be able to reduce the pipeline run-time due=
 to simultaneous runs.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It will be very helpful if you provide your support =
with the above-mentioned items.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith Sathujoda (T S I P)<o:p></o:p></p>
</div>
</body>
</html>

--_000_OS3PR01MB6103F00964E26A0F5D38A8ECC2E92OS3PR01MB6103jpnp_--


