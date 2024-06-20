Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC289C27C79
	for <webhook@archiver.kernel.org>; Thu, 20 Jun 2024 05:56:38 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.40964.1718862990166184292
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Jun 2024 22:56:31 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 45K5uSLF3661275; Thu, 20 Jun 2024 14:56:28 +0900
X-Iguazu-Qid: 2yAbdMiuZwt7MwTpbF
X-Iguazu-QSIG: v=2; s=0; t=1718862987; q=2yAbdMiuZwt7MwTpbF; m=NN/XLf7OSTiWgzpXMjBLcGp9Ouew4aB9Os/VxwMn0SA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 45K5uQJE451281
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Jun 2024 14:56:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqu+Mt2+RtnQ/uG00FfiC4rPEh6wX0GaoztKoiw6yreD9UF3o7vAGYr4wFKww7vdtROsAov5tFW6vIml0nBzJGXbY7rGS1RZmYIM6bRmWIlE47aU/A/Mv0g48CajOLi1bR7vQmJyvulQIeNKcsSgq/jo2sD+J1f35Ttpvz/+AWJOT48M0zpgXsGPsy77LpdLYNeo8l3enEXPnH1LgUfW2RBlx0D2cjJSw65F+p4HHn4eqiQAzB7pIY+Fmd2F/yMwhhMLbbov4l+qqIuvvbvMlT9yonWeSIBvxbXwLuoVY+WDP1LrwJEVVgGPLCZpdhC+5yaxMN4mm3rDvg0mz+GbFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2bPNXEGixxkgT1ySOrFSlk0R7NGdsWf/iPh7zHYszE=;
 b=EVVXaOEoSYnn7Rco9zhcylaT13quaZ0VPyxQmRiOGzLjqGm17R3gMDYfO0h/OZSX+5TtMOrFFqS8K5uXzHK3lU6A9fOsyfCtAs3/fLnqErZCI2tvS5cZG9hLojh0ud8rjqBaMKEpSd7U7JA8TXBFGI0ScZZgCs6Pa36lEfMli3mJn8bDWjJfbzfecL3Ji/cPtp+eE+CETGfrYnTPoc9FZrYj9P7/z3qUVzC4qf/Thp3R5NFr3BSO6HXFHqpqkVNZMWAhKoG100386ntoZ57Mpu782Ncz568YIUy7ySuUL5tBeluGf/HK1GIBrroVsLprJ+IV/09Ja0CLynaY/S5ZMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Sai.Sathujoda@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Regarding support for WFX backend for software updates in CIP Images
Thread-Topic: Regarding support for WFX backend for software updates in CIP
 Images
Thread-Index: AdrC1ksCFU48h0ptQR+cT3Q7rfn9dA==
Date: Thu, 20 Jun 2024 05:56:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669288BB5107DAC76CE3DF7C4C82@TYCPR01MB9669.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|OS9PR01MB12420:EE_
x-ms-office365-filtering-correlation-id: 4ce07b4e-e97c-4087-7515-08dc90edb828
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?c1Jya2lOZDZsUVNHUmtXWGlOYmhsaFB0aEttZ21NUVEzWDg3QXh4Q0Jh?=
 =?iso-2022-jp?B?bDBOYjVYT0FtUVhDQjNSQ2kwSDJhVlh0Q3kzWENRVnU4MVN3c200WHZh?=
 =?iso-2022-jp?B?MjJrekJPenhVdUlBTXFiUWxMcTBIaldFbG1wS1ZsRGVUb05zZGpNQmpw?=
 =?iso-2022-jp?B?WCtPN2htRUN6czU0MmlhRDVQWE9MNGZyS2FaR1VQM21lQTVrczkwd1ZW?=
 =?iso-2022-jp?B?ekRCZ21EanBsWk01SlQ5YVc3TFFmK0VQQkh2cVVtV05vaHFEQlBOUHY5?=
 =?iso-2022-jp?B?andnVUlhMzlZUEgvZXBUVW8rQndJaCt2aXArL2p4MERNUDFscHIxZlo5?=
 =?iso-2022-jp?B?SW1xbUNwM1FoUjhGY2FsS2Y4dENlaSs0aXJvOHUzNkc4OG5lSzMzWXBW?=
 =?iso-2022-jp?B?aEw2cFV0ZlIvK1hIV3ZIK1hrZmJGVUU2ZWRvSjdXQnZ0YVhxOUNCUTF1?=
 =?iso-2022-jp?B?c09ZNjAvK1g2RkpFenNmdEdGajhBVDJIR055NytPNm9hRXgvanJ3M01M?=
 =?iso-2022-jp?B?RFJReUZpUUtNZzZTcEMzQVFacHlkSHdrV3BYbVpNL0NyZTNyeDFpRkEv?=
 =?iso-2022-jp?B?NjdxbHc4VVgxdmh3OTEySThJVUNtTXFoOEFvcWNlSHJmRm9hZFpnNmc1?=
 =?iso-2022-jp?B?UStDOWhxczZYWkdXVGNUNnBMQTBuUkdpenZLOUpNNDV5dytiN2M2YUxL?=
 =?iso-2022-jp?B?bFRpNjJ6WEgrb2J6V1JsS0c0c0VTZWFPb01RTkp2ZGwxc1NhZWp2d3or?=
 =?iso-2022-jp?B?aVMvcFVxU1hQK0pESVBZbXlzQ1BHZXNwNDBSNWNzZnZ2WGFCOGhiV1FE?=
 =?iso-2022-jp?B?WnBmWkRqeXI0SlVJNlhjc3ZJa2ZMaFBUK2pwMGkvdjBmdndyZkd1cHIv?=
 =?iso-2022-jp?B?NU5JajhyczNoRWNRQ2N4YzltcWxXTXZBRXo5a3Q1Q0YzV1BWcjBsbk43?=
 =?iso-2022-jp?B?Q0VzN0dheFZGNk1ZdWE3d2dqVi9tVXFMbEFnbzRMOUNzZGEyYlgrWHg4?=
 =?iso-2022-jp?B?UHQvbzFOUnlwVlQvOFNQSU81eUR1NW9rVThpOWs1d0YxNW5obWFaNU42?=
 =?iso-2022-jp?B?TkxURlY5QWI0YnVmbUlWdWdSL3dkY3pUZzdjdi8zeGtYV3UxL0NIZ3Jy?=
 =?iso-2022-jp?B?czhFaXQ2SGNURHVUcy9CcFVkditvaGxLM3RRWE5zS1F6VXRmbzdkSmJU?=
 =?iso-2022-jp?B?WVNOMjRpdExUc1kzdVU5OUVHb29CMDZ3Tm5jVkJrYk5QR2N5a1l0NVEr?=
 =?iso-2022-jp?B?RzVtLzVCNzc3RmRUR1hGUElmeW5FSEZhVkVVSnFkMHkxempJUUdQTzZj?=
 =?iso-2022-jp?B?eC93Q2lyQSt3Y3NyWkd2bkpkR3hYWEpXN1FJMHZWcy95MmxEek1YM2g5?=
 =?iso-2022-jp?B?QzVVWEVidUxXSjkySlBnRmdFSVYyUCtCWnpEYUlyYlVEM2FMR2hzU3cy?=
 =?iso-2022-jp?B?L3hNZkxwVmZpN3dMQVJRUWd2aXY1bUFpTC84ZVl1eWVIVGwzOHkzSmVJ?=
 =?iso-2022-jp?B?RjQxM1FNUVJLbVA1UFJaY1ZnNkxYNVZhT21iL3M1REdMVFhmYWU5UEZX?=
 =?iso-2022-jp?B?WkpTK1YzV1VzVGdsa2NkdzZaVUZvMk8xUTBmK3NCUStXYmR3QU5WZENq?=
 =?iso-2022-jp?B?K1ZISnRsSkp5b0k4bVAyU1Bsa3Y4dFVodk8vZmlRenpZQU9XSEdVMjk4?=
 =?iso-2022-jp?B?V2h5anFZS3dWb1ZoQzJLRlNHM0RMRlZ6cEUwOFl0cHVBRThjdG0zajBT?=
 =?iso-2022-jp?B?cTB3S2ZwR2FCVnRhU1o1b01QZllRTjVSYWc1TWR2cStvaXEvem16UTBv?=
 =?iso-2022-jp?B?b1pyc1U3U0pSb2lHeXVsZjJtUlRVdFBuU2xTUzEvaE53WDZVeEI5RmxV?=
 =?iso-2022-jp?B?bVovOXYwc3NJWVUwWkVCYXBCR2swRFliNUV4VXo3Ung1R0xxYlNScGxQ?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?LzBSU1U5WE1RWCtxeFlmbUtxUHNJTnR1UTdIUytJdkpXQ3NYV25KYUFa?=
 =?iso-2022-jp?B?NGhHV29DUmNSSU1jTG9ySCtRMmxuRlNCRUFweGdIQ2laeFUvMVYrU2dh?=
 =?iso-2022-jp?B?UWVOY0E1cDNsZkk4czR0dzdBd3Uva1F3a3BMTC9xa0J5a3dSUmZjUVNU?=
 =?iso-2022-jp?B?TEhqOEV0SFFXT0JNem1FQnZQaVk2bHc3TGxhc25sUkVZekRFclQ2Ynpv?=
 =?iso-2022-jp?B?RnNJcStHb0l2ek40bit1dzA3OHNOZ2Y3RTU2cXdtU3hvdW5Eekd1YU1E?=
 =?iso-2022-jp?B?aFNudTdQR0tzMjMra3BlWEhPdDR4Q215MjMxQzQ4dFRyZWl6bituMi9z?=
 =?iso-2022-jp?B?ZHhLODdzS09PaWI1MHVEdTlFYnpTRko4emZLN0p2VWZZZjVmeWZzeXhq?=
 =?iso-2022-jp?B?OXlHNTVyZWJWbE9BUFExTHRWa1MzbjBuRXcwaFpydFV2K0JhNjM3M2xI?=
 =?iso-2022-jp?B?QW10bjdsV3FUbTFoRXFBL3NWV2FLekZWSkhTSWpuQUp2RmVtYUdsRThu?=
 =?iso-2022-jp?B?R1hKS0xDWTgzSUV4ZVNFMjdQbG9JSzRWdlZjbTlJZmdBT1ZkRS93SHpK?=
 =?iso-2022-jp?B?YWl2cUhIWUZyWnBjYUZwYmQyWkVqaFpHKzJ2OWhUWVoyc1pQT2E1N3RQ?=
 =?iso-2022-jp?B?bDN3SnFadWMvZkJDNmNHR3BMS0lqeUNZV2RpdWQ5OGZqWXpnVHByQStr?=
 =?iso-2022-jp?B?TFhFeWlwUlJIdDIxc01CbmtOUld2eXNVcXk4c2VveTZ4cjFZOFRaSUJX?=
 =?iso-2022-jp?B?K2lHbDZKdXZTRXo3aFJDK1M2K2g0WWtNa0JNUlVzNVNOZ2s0UXgrY0hP?=
 =?iso-2022-jp?B?M0JFWFI4RFZLc0NXcXRZUnZsejBkOTNWM0VieTRUWTBzd3pLdVBXWVlW?=
 =?iso-2022-jp?B?L3N6YUo5NEd6eDZlV0ErKzlLZHgyZU9iSXNxQWhMNi9oS3JZTS9PRUcr?=
 =?iso-2022-jp?B?VWF3ekFnMVFrREhVS3laQzN0OEVuTXhKY3RTQzRTQlhTb3Q2RDlOSFYw?=
 =?iso-2022-jp?B?MTZReFhIOStaK2MrdEcyL2kxQk5CbnVtS1R2TFhHQmtwNEp3N2ZBc3V2?=
 =?iso-2022-jp?B?UGdERE5sYTRPNFBBNXhDREhvdE42YlJpc0NCNlAxOTlIbzQxaGFRdFRm?=
 =?iso-2022-jp?B?eEtJZFJYZ0d6UXZGK09lbk5OdlNCVXA1V0puWkt6dGxwd2JycUI4aktF?=
 =?iso-2022-jp?B?ZTJqbDVLc0l3NlRlN1ljZENNMkg5ck9iSXA1R3l0bmJiRnpEemtsbUs1?=
 =?iso-2022-jp?B?MkdMVFBuQjNxSU85QXhZVnBvTUFsZFcwWlpML1Vwd3lMNWJsLzd2eXhJ?=
 =?iso-2022-jp?B?RVMwUi84c1UyZW40SVJBMHRDWWR3RzZNWGc3bVBjYUxudWtCVTloWXd4?=
 =?iso-2022-jp?B?WFRlV0k0TmgvdzhjdEFXaHVVbE93T3paaVFCM2hGOUJ3QUhzZWFsR2Ja?=
 =?iso-2022-jp?B?NlFYb08zZkdad1dOaHp0TlRERUFYWFdPbDhNeGdvUG9IT2QxOXh1RUJL?=
 =?iso-2022-jp?B?M2gyWjFhVnpIQnhnSFBRVXBYNWtLVmpEYTZPa01ZZDFUM0FEdVpUN1Nq?=
 =?iso-2022-jp?B?SGl3cHBWemFrRWNZVGp5UldhVUJvOENnY2dtUUN5MzFRenFRQWxPMDRL?=
 =?iso-2022-jp?B?QmNCMmV3VW53WmZvV2F3MDVodzdVL2xlQUlVVXNEbFNhR3Y3T2RSb2Mw?=
 =?iso-2022-jp?B?Z0FXbHEvdUZSQWRDd3Q2dlU2MS9vYS9XTW5WaHJ0RUFFQVJFWStBN2dB?=
 =?iso-2022-jp?B?QXQ2WjdqSG5RVHg5cVVxSVVsVHdIWS9NaC9ZRGxUbGo3U2JWWUFuc0w1?=
 =?iso-2022-jp?B?VTBYNHNnOWZyY1crU0tSRWM5eGVIUno4Q05WWTJ6WnpkcXpBd3JMenlt?=
 =?iso-2022-jp?B?Z01xMFJDNk1kelh5ejg4MnYwYis4dzlWNmFmTUVqSUFwR2ZMNWF5RXVj?=
 =?iso-2022-jp?B?TUxZcUJaV1luaDQwajY4bmVDaFlpc2ZoL3g1cXZTQVRaRy83UFZMV2E3?=
 =?iso-2022-jp?B?QWU4TlROb3dreVdobWdWYkxoR3A0QlMvS0NRSktpUjYybnVOTmRnMnFT?=
 =?iso-2022-jp?B?RWpiam1ZNGozN2ZTV2JvZmVpL2dmNUdQOXZkSHBjUGc0Wm40aDFvYUZa?=
 =?iso-2022-jp?B?b2lLS0dGVnB2YnJCQnYrSk44ZmJZUjEwMm5lQkE5SzV2UnZmSDBnS0ZM?=
 =?iso-2022-jp?B?bzg5WEgzYXJhRWRydkRhdmx6RXBvcFN1TGNaY0tMWXpJMTd6RmtXRkgz?=
 =?iso-2022-jp?B?R29JYndBbm5LZzdoRG9UejlEOHNCaXVGM3NWTUJ1K0VKY0ZUbmxtbHdw?=
 =?iso-2022-jp?B?bVJPanR5SXpkcklTbE5pWnRlVktKNjlWQVJTZHNxdTdsTk01SndwdUpr?=
 =?iso-2022-jp?B?VlpmcEE9?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669288BB5107DAC76CE3DF7C4C82TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce07b4e-e97c-4087-7515-08dc90edb828
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2024 05:56:25.0932
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZG19tOHbkXB4BxeCaGxs+4Ayf2dZ90N570gKdzoj4ur9IM/12mVXNiVZYYTPFfmcE6dEu67YDM4jzibWBF4T/jYt8CvRgztCVGqfv85IlcsmoVNDuPyIAD/Wv4t+LHdg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12420
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jun 2024 05:56:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16301

--_000_TYCPR01MB9669288BB5107DAC76CE3DF7C4C82TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi All,

This is regarding support for WFX backend for software updates in CIP Image=
s. I am writing to understand the opinions of the community on how to go ab=
out with the integration of WFX support.

As I understand there are 2 parts to the WFX integration:
1. Hosting the WFX server.
2. Suricatta configuration in the CIP Images via the swupdate.cfg for commu=
nication with WFX server.

As from the device side, communication with the WFX server is already suppo=
rted by SWUpdate through the server_wfx.lua module. See [1].
However the necessary suricatta configs in the swupdate.cfg file are requir=
ed to be set which is currently missing from image recipes.

Based on CIP Core work group meetings, I understand that there is already a=
 plan to host a WFX server for CIP related purposes. While that is still in=
 the works, would it be alright to update recipes to include the necessary =
configs needed for WFX support or wait for the server side to be completed?

Until the planned WFX server setup is completed, how about including detail=
s of setting up a WFX server and other details for minimal verification in =
a README file?

Would like to understand the opinions of the maintainer and the rest of the=
 community on such an approach and also other ideas on how to go about with=
 this integration?


[1]: https://github.com/sbabic/swupdate/blob/master/suricatta/server_wfx.lu=
a


Thanks and Regards,
Adithya Balakumar

--_000_TYCPR01MB9669288BB5107DAC76CE3DF7C4C82TYCPR01MB9669jpnp_
Content-Type: text/html; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-2022-=
jp">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Aptos;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Aptos",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:11.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
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
<p class=3D"MsoNormal">Hi All,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This is regarding support for WFX backend for softwa=
re updates in CIP Images. I am writing to understand the opinions of the co=
mmunity on how to go about with the integration of WFX support.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As I understand there are 2 parts to the WFX integra=
tion:<o:p></o:p></p>
<p class=3D"MsoNormal">1. Hosting the WFX server.<o:p></o:p></p>
<p class=3D"MsoNormal">2. Suricatta configuration in the CIP Images via the=
 swupdate.cfg for communication with WFX server.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As from the device side, communication with the WFX =
server is already supported by SWUpdate through the server_wfx.lua module. =
See [1].<o:p></o:p></p>
<p class=3D"MsoNormal">However the necessary suricatta configs in the swupd=
ate.cfg file are required to be set which is currently missing from image r=
ecipes.&nbsp;
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Based on CIP Core work group meetings, I understand =
that there is already a plan to host a WFX server for CIP related purposes.=
 While that is still in the works, would it be alright to update recipes to=
 include the necessary configs needed
 for WFX support or wait for the server side to be completed?<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Until the planned WFX server setup is completed, how=
 about including details of setting up a WFX server and other details for m=
inimal verification in a README file?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Would like to understand the opinions of the maintai=
ner and the rest of the community on such an approach and also other ideas =
on how to go about with this integration?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1]: <a href=3D"https://github.com/sbabic/swupdate/b=
lob/master/suricatta/server_wfx.lua">
https://github.com/sbabic/swupdate/blob/master/suricatta/server_wfx.lua</a>=
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Adithya Balakumar<o:p></o:p></p>
</div>
</body>
</html>

--_000_TYCPR01MB9669288BB5107DAC76CE3DF7C4C82TYCPR01MB9669jpnp_--


