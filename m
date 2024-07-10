Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D43C3DA45
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 09:17:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.9947.1720603072530285327
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Jul 2024 02:17:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=ViR8L+a+;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version;
	i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key2.smx;t=1720603050;x=1721812650;bh=KF
	Vl09hl/dqyCxeHW24odpPC13bA5k5cGou3yrELP3s=;b=ViR8L+a+NYedwTIZlsD9cjuR/miGjwPS
	BGTo/oFkekdeC9vAHWvc0RmjFwP0QKhCdUXdRDoNTS6tzOldRfTNh1nHMOHYEVt5CB7uz7XU4wBpn
	loe/qDWylho+120tGl9YPHwb93nRsrKfUstvDtsFFZxQDmVxbK+xos2QSt1fSxBYJ2ron5eNEDMy+
	UXLrf8Z3Nvg/0ySRp8rWe2sxKocr9ZUDSUudyd8kmLdA0VD3lmovyJqUQu5XJVu5j8+zyxN9yJims
	J+2QSnFDt5K/R6KiHbRDmINd8aUb95eECsXtW8wr1tYLMZ7S6n4fbRxT0IiAhyqcaanuEUz1T+IN1
	1A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 46A9HTFB3959402; Wed, 10 Jul 2024 18:17:30 +0900
X-Iguazu-Qid: 2rWgw1SKKllQsbErbN
X-Iguazu-QSIG: v=2; s=0; t=1720603049; q=2rWgw1SKKllQsbErbN; m=hZ7G888Rbhlw4du0O+HbcxQ3JENzex0jWT+JVjX1n1o=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 46A9HR1q3738798
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 18:17:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nj0zVK25NklC/m0+EE9IomQhjCLb+iVIm7Ci6ZLOOOsKhGALDYtGyEv+GDAzhnmTz2VDWTyLRCb3dF9pTlbECFgsEfb2M8sD+i1J0tMTn4kDgAMazaSXWXWD/YYj2jW5tzP/FF9IipCaKcCDFs1wH3DVgcNA+ZpTXzWO0HH5Km8Cm/bgLImoIZSK1AT62ZdXBeO9FP1uHk2y9ITQRJkkiY9cSjIKAjaxXipgyy6oJ0LSNboASnStJCUrVScAwTsC0L+/bJAbLUKQDnkrAuCLd4mN1cI4S+HX5kfLQpsYltCv2d5and5KciLslwmAiarwR797wos2WCWMERMv2IOj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L4W3YuVgBf0/SGExsczE57mzN4Ed2oDUoYbNrMLRjZg=;
 b=ert4WrQZDJWldcOKf4FPq/d9YCZvv5R8dFUpobx0thUVe81mhW68Wh16EgiH+yMqXB1BMWZ08oyLfHN/QytMvrmCrQY0map5ST9usL+wDPeWlhZLOsLcWALF3tEEvlq2xkIDemheKUCcyiM1L9OXbiL2hILHfiYcScP0QlIT3GRa3yJGwR4S1KBSufr88yY864D7hcxfVkSLHJ223MTC4uY27sk61iO2c7Iztc2Y1fNysiIfHUmaSYPKlCynhaPhQkcrcpUAPx1zpPYhQrRMBLbQA2TELVQIvCf5UKRYie3zZkilKM26JX8B2PrZlMe2EgbHtFZRvfL9fTcaekL6tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: [ANNOUNCE] Release v4.19.317-cip111 and v5.10.221-cip50 and
 v6.1.96-cip24
Thread-Topic: [ANNOUNCE] Release v4.19.317-cip111 and v5.10.221-cip50 and
 v6.1.96-cip24
Thread-Index: AdrSqa7JtlxYGSwXQx2VxPdmkCDN6Q==
Date: Wed, 10 Jul 2024 09:17:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388081D4E9EA2AF33615F7E92A42@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OSZPR01MB9362:EE_
x-ms-office365-filtering-correlation-id: ed724c70-3034-422c-9fbf-08dca0c11bed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?UGJ0djFsLzQ2Qmc3d0UxZDdrbitocXQwaXZvWXo1THlURDZjTkdZYWxQ?=
 =?iso-2022-jp?B?cnhaQ2NnQzdWZ1Ftd08wbjJFS1p6cjdwYytGeVg1RUE1TW1URGdNekVT?=
 =?iso-2022-jp?B?RFJUenRub3VCSmJVU3MzeElSMzR4RXdWZlVsdEkwV2ZIZTVvZ2JRSnBa?=
 =?iso-2022-jp?B?UHdpUWNSY04rTHBNZFJZcUJqR2hsYjNHVGVMVHdhMVJ3NzZZd3B3cUt0?=
 =?iso-2022-jp?B?RDlmN0VOM2JzNVd2TEVmL1p5aE91a3Z6WllybkYrakVLbnlKSDNFbWI2?=
 =?iso-2022-jp?B?RDR4N2FVOXhBUExWMzFQMTArSUdhTjZXbXcrcGgwdjNBVmJCYXFIbWlw?=
 =?iso-2022-jp?B?NVVTREswbmJhVjd3NHF1M2dVTzBTRngwK1VrdVZqTCtCdnBXMU5id2pN?=
 =?iso-2022-jp?B?YzJUQTBySDF3cVZGZUlLcGFqcjJKblhUT25tZjJRWVFabjN0Y2dvakZr?=
 =?iso-2022-jp?B?bW9HaUszZml1aUZFTVpvQjlmcUpjUHlXcTYwdmR2OUJaVURRZFV2c01J?=
 =?iso-2022-jp?B?RFQrT2tUTEh6OUF6RmV3cVpDZ3h5Z2h5QllJbHNBM1BnR1BIZnpGK2N6?=
 =?iso-2022-jp?B?aEVoeFdlL1lXY3kzTmpnTjFObFNYL0xnSVYrWGp1Zk9nV2F6bE92Sk1N?=
 =?iso-2022-jp?B?b3pTN3d1eHhXbGVvTVFNa2hTZUZPVjZrYy9wYUxMbDVUTjN5QmlyaTBR?=
 =?iso-2022-jp?B?Z0EzQkkwTitabnFTNFNJVXYzWVhqOVFwajI1UlArKzlzSnJxU01wL0NO?=
 =?iso-2022-jp?B?SGxJUTNmSVlxejNrQTBHZjROMENtNmZqTDVnZ3Z6bSs0TjBrMUtEZEdq?=
 =?iso-2022-jp?B?VFI0bVlwckFYVkVtUUJ4SWEvbFY3aFIvYkVxZjhqdWZrOTNKZ1BDOTU0?=
 =?iso-2022-jp?B?QlViZzhSeXlRL083RnJYZU5mT054dzg1eGI0TzVKbVRCQVhCWlJkdE1h?=
 =?iso-2022-jp?B?eFUvRGlKc0xsZTRpZHdNb3Jhek52RDJZa251QVU3blRoRk14VzV3SEd0?=
 =?iso-2022-jp?B?cG1BT1RVaFhZZ2dwZHFpOHljODlmMkpUWk4rWUVlcGxVL2ZpUDlweDBx?=
 =?iso-2022-jp?B?OW1RQTYvUHp2b2dRdmJEbHBMMlR5bHJIUlViSlZJeGdpKzBISzVQUVU0?=
 =?iso-2022-jp?B?em1jQnFrUXhVQ2Iwb2pJTFM2dzkzOEFIMThobEZRTVk3TjFjUFk5Y3Jm?=
 =?iso-2022-jp?B?V1l4MUtuUHFsRnNMYlNabjI1ekhZSzdFd3d2ZGRrdktpTFZSdGo5TG5l?=
 =?iso-2022-jp?B?RUZ0aGhZTXZkdnBOeThOb3ZWQklMWlZLU1NtZEJUZWgrWVpnTGpLbjgw?=
 =?iso-2022-jp?B?MDVLTFcrRVEzSVBaNk5LM0M1MC9rTVRaWm5qbjIzMnowNnpHUUhycjIz?=
 =?iso-2022-jp?B?WTh5dERoZittcGNZVll3M0Nndnp6R1cvaVI0aEw4SWNCQ1cvMzlSZDVj?=
 =?iso-2022-jp?B?WnJtVzRXQWE1Zk5wM0RxMXhZbktML0lCc3ZCMkNuNk1sRG1kSW8veUtM?=
 =?iso-2022-jp?B?UitkOFhWaGtLaWRWUzZ0ekNZT2NGZ3Y0NHF1VlVraGxLaFYxMlpwQStp?=
 =?iso-2022-jp?B?N0ZxNDFadkZqUC9CMVZKMm5uWFAyc29JZXZpcllmbitQb0prY3FhT3BI?=
 =?iso-2022-jp?B?c3g5QUFlamtYQ0tua0xQVDAzQ2RTMG1adHZBNFlYUU9uaEo2amZPQURh?=
 =?iso-2022-jp?B?RVdnaW1TcS9BZzNVekwxbVMxbTVoZWtMa0YzZ0VnaWhHaGZpcXlWdytk?=
 =?iso-2022-jp?B?a2huNWpSdGFnMUtkMmhKTjZHVlNvaDZ2MmwxcUtvS2RTaDMzWTJ1R25v?=
 =?iso-2022-jp?B?NnpHRU44VHNQT200SVdmVXRHTmZmcVVSVzIwRkJQV3U3RHlNUDRNU2Qw?=
 =?iso-2022-jp?B?VU1uNnc3WEVjVzNhL1BUMFZ2b2xUOWl0QTJUakJMb2hXQUhkcU9xelVm?=
 =?iso-2022-jp?B?OUxVbmxQdk9oRnpkQzFFYnFKUWk1VTFDWVZKeDkrU3BRWG45aGltK1BT?=
 =?iso-2022-jp?B?QzZ1UEkzNHdHSmJ3UEtreGdpSzd0WThtaDhvNUhKOHh5ekxsUFh1VWl0?=
 =?iso-2022-jp?B?VWNqeVJaMVdnRTZma3Y5cGREWVRUaDdYWUU2Y09IOGNZWFJiaEZUNXBi?=
 =?iso-2022-jp?B?aEk=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WFV6M0ladlN4Yk1VVnpjOWNuTmtWSlBoajllVUZZRXlvWnBuMHV0ZUwx?=
 =?iso-2022-jp?B?M2FrNjlObk5KM2xXTkQyUVY3UitEU3RySzZNTEczbUp5TDFHQlR4QjNB?=
 =?iso-2022-jp?B?d1F4ckpLWklES1RnUm1sK0RNeDZLbWtnNDJuZE12eENTdUtwVFc3NXBy?=
 =?iso-2022-jp?B?ektYbVo3TGN0RWNjVWpuUE5BNFNyUVFONEFaWCtDRTlOaERoYTR3WGVO?=
 =?iso-2022-jp?B?K3RkekIvbnU1bzRxVTcrQjAvbW9LWWcvM0FpUWhxdlV3bTN4U1NISFZq?=
 =?iso-2022-jp?B?Rjc5WkRYeWNUNDhBZDZYcXVWam9acFBNbWIxeWtSUTdoMVFrMG94QlZt?=
 =?iso-2022-jp?B?Z0tHMEZLOVhSazEyVncweXphRDZEd1IraGd4RmhRRGFmMEZZODRrajg5?=
 =?iso-2022-jp?B?VGJ1UFFObzZwdGh2VGx0c1dkdXlNcVduR3lxNnlEdk5vR242VUJ4UHpK?=
 =?iso-2022-jp?B?dXovTW5MRDZueWx0R1hiTzJtMzNEa1hkdU0zRzFaQ2RCb043VGN4N2g0?=
 =?iso-2022-jp?B?eHd6am8rek5UVkVaMVJkSCsvY1p1UjBGMGxkb3hqUHV5ZVBBaHNaNldi?=
 =?iso-2022-jp?B?R0JJM3hGQ0VBazZuQU1CLy9DV3FYL2QxSmFDc25zbm55elczbHlYVkVU?=
 =?iso-2022-jp?B?ODRoWlNOQnQ3dGdBNzUxeVNqdVAzdlBoTUMzc0FGTlVXNnFpNlk4aHU0?=
 =?iso-2022-jp?B?cDhGZkRraTRkbnJUSit3WjRaWW9MaVZrNms3c3dVOTErZ2Z5WnRCa1pX?=
 =?iso-2022-jp?B?azdmRWlHQmJHeVp1b0pPZGdBWGdjR0ZXRzZEQmtIQVpEYXhUNlV0dTlE?=
 =?iso-2022-jp?B?Ykw1QnBkS24yRGxQSzlHSjRZUW1HejFPQzJ1YW5NclhnSmtJVE0xNkR6?=
 =?iso-2022-jp?B?ckIxU282MTJnRGNOOWpYeENRdjVNSzh3TXhWVFZtL2hNY0ZMN1BaWWUr?=
 =?iso-2022-jp?B?R0FvVFVUcUhnUFlqanVaN2sxcFI4SXV6ZkhrTEZ6ZDFCVitsMnh5bEpY?=
 =?iso-2022-jp?B?VWZIeEdHd0NvSFNJSUNvWEVKS2tmeVBqbXVzQnp0TUNQd0txaThtQXRx?=
 =?iso-2022-jp?B?aW82TnY2RW5XVFo0eWkyMlNsN1hGZkc4bWFLVEoySEVEYXNtZ2RCWHBH?=
 =?iso-2022-jp?B?MzZZMTRlRVNybGE0VmpVc01CMlZtYVA5SWtJbG9EeFZFYjEzeldvYzY0?=
 =?iso-2022-jp?B?TWF5aDVkUTVTdW5rL3pYTmFWczZqSWc1ZzdlM1JRZFRtNGFwRHJwckYy?=
 =?iso-2022-jp?B?bDVYRE9rb2JVVll1cDVkTGVXUm9RWGx0R2JFUkkvY1hQbjZ5aE5MbTBC?=
 =?iso-2022-jp?B?THdMVTdvY3RibjlYRXl0NmU3UGptTVAxU3o5WW5HVnBWNGJLMjNIcFRW?=
 =?iso-2022-jp?B?MGNaMjBQMG16eE16REExc053OGI1RkprVlV1SVp0TElJTmIxQ1RacGQ2?=
 =?iso-2022-jp?B?dlRtelJkYy9EVjNic2phWm9DenhXWko4L0FlbXJnaWdMdnNTTStLbzJs?=
 =?iso-2022-jp?B?YmdhU0NNSXpMOWhnRkZWTDJLL09SRjE4UmNycDZlTmwwRmtqQ0s1ejZn?=
 =?iso-2022-jp?B?cDVDVWJIWEtIbVJ2OHA1UmZEUS9SdkY0N0ZPUUxnWGxWVWdGdDFHWXNt?=
 =?iso-2022-jp?B?NkR1U1J0amtpRDBrdlNrRDlaM0UxckJTN29ETnpOdW5JMTcxNGZoSlM0?=
 =?iso-2022-jp?B?bW9CV1FVbkROSlV2elE3NmlESzJhZkp5NW1xYnZOK3hWMmtDb0k0bk5R?=
 =?iso-2022-jp?B?WmVuNHNSbkNFL0FQdEQyWXkzbUo0OXNVUjdwb3FqaE1SZmpYNnMrWnJy?=
 =?iso-2022-jp?B?NDJtT3B0VE81SVpvcTgxWjRKN1NiRGxMRU9GbTk1WUlrY0ZDV3A3Z3Vs?=
 =?iso-2022-jp?B?UXhCRW1lY3JodHBqWXdwVjArWGZBYXhZcFpGSHRrNFNNOFptYlRvUUR5?=
 =?iso-2022-jp?B?Q0doMHhManR2TUphdkZLWldKa0FNUUhjc1lnNU9ROFEyZWZvWGxENFNR?=
 =?iso-2022-jp?B?cXlJbWlWTTEzaHZma0k4bTRqeEI2bFV6eVkyVS9QN2N6d0pVbnllNC9w?=
 =?iso-2022-jp?B?NnBDNlBncXkyNmt5Z01JMDdQK2FueVZibHRhSTVMQ1ROOTVOV3pVUGEv?=
 =?iso-2022-jp?B?SkhlRDd3RTcra2FRZ3hjT3VsRFNjRUUwZmpxb0ZlNlR3cmhtVnpSdkFs?=
 =?iso-2022-jp?B?ZENuc01QaGg0MS9SWk01T2Y1bFhXcmZsYzNueUFsMjZjMTljOWgrOCtP?=
 =?iso-2022-jp?B?YnUxVkJRSitnOGh3M1JJVEcyT1JkRWJkYnhPVi9pUDcrTzNreHJTc2lh?=
 =?iso-2022-jp?B?Qk5YTDU1NkxBdjk0clJBNmRPaFVjdXVvelE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed724c70-3034-422c-9fbf-08dca0c11bed
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 09:17:23.7105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsJ+IC+9UdAr/YWmapoXhZoNkJpohuUdn370ZXu/Zj42li3qYAo0aw6rzglyqwB6GSPSjvwzqAsNv92PhFg0uH6Tqc95rpXhVfm68RFLymVOt+kWnmjffA/eH4IyyiMe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9362
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Jul 2024 09:17:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16447

Hi,

CIP kernel team has released Linux kernel v4.19.317-cip111, v5.10.221-cip50=
 and
v6.1.96-cip24. The linux-4.19.y-cip tree has been updated base version from
v4.19.315 to v4.19.317, and the linux-5.10.y-cip tree has been updated base=
 version
from v5.10.218 to v5.10.221, and the linux-6.1.y-cip tree has been updated =
base version
from v6.1.94 to v6.1.96.
The linux-5.10.y-cip tree and linux-6.1.y-cip tree have been updated with f=
eature addition
and fix patches for Renesas ARM SoC and RISC-V SoC.

You can get this release via the git tree at:

  v4.19.317-cip111:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-4.19.y-cip
    commit hash:
      9adf72a2f9807d3ca20128711c0610328a7bae28
    Fixed CVEs:
      CVE-2024-35897: netfilter: nf_tables: discard table flag update with =
pending basechain deletion
      CVE-2024-39301: net/9p: fix uninit-value in p9_client_rpc()
      CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack OOB wri=
te
      CVE-2024-38621: media: stk1160: fix bounds checking in stk1160_copy_v=
ideo()
      CVE-2024-38612: ipv6: sr: fix invalid unregister error path
      CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receiv=
e()
      CVE-2024-38599: jffs2: prevent xattr node from overflowing the eraseb=
lock
      CVE-2024-36971: net: fix __dst_negative_advice() race
      CVE-2024-38549: drm/mediatek: Add 0 size check to mtk_drm_gem_obj
      CVE-2024-39475: fbdev: savage: Handle err return when savagefb_check_=
var failed
      CVE-2024-38579: crypto: bcm - Fix pointer arithmetic
      CVE-2024-36015: ppdev: Add an error check in register_device
      CVE-2024-38381: nfc: nci: Fix uninit-value in nci_rx_work
      CVE-2024-38589: netrom: fix possible dead-lock in nr_rt_ioctl()
      CVE-2024-39480: kdb: Fix buffer overflow during tab-complete
      CVE-2024-38637: greybus: lights: check return of get_channel_from_mod=
e
      CVE-2024-38780: dma-buf/sw-sync: don't enable IRQ from sync_print_obj=
()
      CVE-2023-52433: netfilter: nft_set_rbtree: skip sync GC for new eleme=
nts in this transaction
      CVE-2024-38578: ecryptfs: Fix buffer size for tag 66 packet
      CVE-2024-38560: scsi: bfa: Ensure the copied buf is NUL terminated
      CVE-2024-38558: net: openvswitch: fix overwriting ct original tuple f=
or ICMPv6
      CVE-2024-38627: stm class: Fix a double free in stm_register_device()
      CVE-2024-36288: SUNRPC: Fix loop termination condition in gss_free_in=
_token_pages()
      CVE-2023-52581: netfilter: nf_tables: fix memleak when more than 255 =
elements expired
      CVE-2024-38601: ring-buffer: Fix a race between readers and resize ch=
ecks
      CVE-2024-33621: ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_out=
bound
      CVE-2024-37353: virtio: delete vq in vp_find_vqs_msix() when request_=
irq() fails
      CVE-2024-38633: serial: max3100: Update uart_driver_registered on dri=
ver removal
      CVE-2024-26835: netfilter: nf_tables: set dormant flag on hook regist=
er failure
      CVE-2024-38565: wifi: ar5523: enable proper endpoint verification
      CVE-2024-38659: enic: Validate length of nl attributes in enic_set_vf=
_port
      CVE-2024-38567: wifi: carl9170: add a proper sanity check for endpoin=
ts
      CVE-2024-38598: md: fix resync softlockup when bitmap size is less th=
an array size
      CVE-2024-38618: ALSA: timer: Set lower bound of start tick time
      CVE-2023-4244: A use-after-free vulnerability in the Linux kernel's n=
etfilter: ...
      CVE-2024-26581: netfilter: nft_set_rbtree: skip end interval element =
from gc
      CVE-2024-39292: um: Add winch to winch_handlers before registering wi=
nch IRQ
      CVE-2024-39276: ext4: fix mb_cache_entry's e_refcnt leak in ext4_xatt=
r_block_cache_find()
      CVE-2024-38583: nilfs2: fix use-after-free of timer for log writer th=
read
      CVE-2024-38613: m68k: Fix spinlock race in kernel thread creation
      CVE-2024-38596: af_unix: Fix data races in unix_release_sock/unix_str=
eam_sendmsg
      CVE-2024-38634: serial: max3100: Lock port->lock when calling uart_ha=
ndle_cts_change()
      CVE-2024-24863: [REJECTED]: Null pointer dereference bug in malidp_mw=
_connector_reset
      CVE-2024-38559: scsi: qedf: Ensure the copied buf is NUL terminated
      CVE-2024-37356: tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      CVE-2024-38661: s390/ap: Fix crash in AP internal function modify_bit=
map()
      CVE-2024-36014: drm/arm/malidp: fix a possible null pointer dereferen=
ce
      CVE-2024-31076: genirq/cpuhotplug, x86/vector: Prevent vector leak du=
ring CPU offline
      CVE-2024-36286: netfilter: nfnetlink_queue: acquire rcu_read_lock() i=
n instance_destroy_rcu()
      CVE-2024-38582: nilfs2: fix potential hang in nilfs_detach_log_writer=
()
      CVE-2024-38607: macintosh/via-macii: Fix "BUG: sleeping function call=
ed from invalid context"
      CVE-2024-38552: drm/amd/display: Fix potential index out of bounds in=
 color transformation function
      CVE-2024-39476: md/raid5: fix deadlock that raid5d() wait for itself =
to clear MD_SB_CHANGE_PENDING
      CVE-2024-38587: speakup: Fix sizeof() vs ARRAY_SIZE() bug
      CVE-2024-26643: netfilter: nf_tables: mark set as dead when unbinding=
 anonymous set with timeout
      CVE-2024-35900: netfilter: nf_tables: reject new basechain after tabl=
e flag update
      CVE-2024-27065: netfilter: nf_tables: do not compare internal table f=
lags on updates
      CVE-2023-4881: [REJECTED]: netfilter: nftables: exthdr: fix 4-byte st=
ack OOB write
      CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.
      CVE-2024-38619: usb-storage: alauda: Check whether the media is initi=
alized
      CVE-2024-35976: xsk: validate user input for XDP_{UMEM|COMPLETION}_FI=
LL_RING
      CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long lo=
op on I/O errors
      CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of write=
back flag waiting
      CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.
      CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and =
AIO request complete
    added commits:
      CIP: Bump version suffix to -cip111 after merge from stable

  v5.10.221-cip50:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-5.10.y-cip
    commit hash:
      d51eece9d08b331aac5a1d4e1410f6b345b1e04b
    Fixed CVEs:
      CVE-2021-38202: fs/nfsd/trace.h in the Linux kernel before 5.13.4 mig=
ht allow remote
      CVE-2021-4090: kernel: Overflow of bmval[bmlen-1] in nfsd4_decode_bit=
map function
      CVE-2021-47002: SUNRPC: Fix null pointer dereference in svc_rqst_free=
()
      CVE-2021-47107: NFSD: Fix READDIR buffer overflow
      CVE-2021-47213: [REJECTED]: NFSD: Fix exposure in nfsd4_decode_bitmap=
()
      CVE-2021-47316: nfsd: fix NULL dereference in nfs3svc_encode_getaclre=
s
      CVE-2022-3566: tcp: Fix data races around icsk->icsk_af_ops.
      CVE-2022-3567: ipv6: Fix data races around sk->sk_prot.
      CVE-2022-43945: A buffer overflow bug was found in nfsd
      CVE-2022-48772: media: lgdt3306a: Add a check against null-pointer-de=
f
      CVE-2023-1652: NFSD: fix use-after-free in nfsd4_ssc_setup_dul()
      CVE-2024-24863: [REJECTED]: Null pointer dereference bug in malidp_mw=
_connector_reset
      CVE-2024-25741: usb/f_printer: WARNING in usb_ep_queue
      CVE-2024-26629: nfsd: fix RELEASE_LOCKOWNER
      CVE-2024-27019: netfilter: nf_tables: Fix potential data-race in __nf=
t_obj_type_get()
      CVE-2024-31076: genirq/cpuhotplug, x86/vector: Prevent vector leak du=
ring CPU offline
      CVE-2024-33621: ipvlan: Dont Use skb->sk in ipvlan_process_v{4,6}_out=
bound
      CVE-2024-33847: f2fs: compress: don't allow unaligned truncation on r=
eleased compress inode
      CVE-2024-34027: f2fs: compress: fix to cover {reserve,release}_compre=
ss_blocks() w/ cp_rwsem lock
      CVE-2024-35247: fpga: region: add owner module and take its refcount
      CVE-2024-36014: drm/arm/malidp: fix a possible null pointer dereferen=
ce
      CVE-2024-36015: ppdev: Add an error check in register_device
      CVE-2024-36016: tty: n_gsm: fix possible out-of-bounds in gsm0_receiv=
e()
      CVE-2024-36270: netfilter: tproxy: bail out if IP has been disabled o=
n the device
      CVE-2024-36286: netfilter: nfnetlink_queue: acquire rcu_read_lock() i=
n instance_destroy_rcu()
      CVE-2024-36288: SUNRPC: Fix loop termination condition in gss_free_in=
_token_pages()
      CVE-2024-36489: tls: fix missing memory barrier in tls_init
      CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and =
AIO request complete
      CVE-2024-36971: net: fix __dst_negative_advice() race
      CVE-2024-36974: net/sched: taprio: always validate TCA_TAPRIO_ATTR_PR=
IOMAP
      CVE-2024-36978: net: sched: sch_multiq: fix possible OOB write in mul=
tiq_tune()
      CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of write=
back flag waiting
      CVE-2024-37353: virtio: delete vq in vp_find_vqs_msix() when request_=
irq() fails
      CVE-2024-37356: tcp: Fix shift-out-of-bounds in dctcp_update_alpha().
      CVE-2024-38381: nfc: nci: Fix uninit-value in nci_rx_work
      CVE-2024-38546: drm: vc4: Fix possible null pointer dereference
      CVE-2024-38547: media: atomisp: ssh_css: Fix a null-pointer dereferen=
ce in load_video_binaries
      CVE-2024-38548: drm: bridge: cdns-mhdp8546: Fix possible null pointer=
 dereference
      CVE-2024-38549: drm/mediatek: Add 0 size check to mtk_drm_gem_obj
      CVE-2024-38552: drm/amd/display: Fix potential index out of bounds in=
 color transformation function
      CVE-2024-38555: net/mlx5: Discard command completions in internal err=
or
      CVE-2024-38558: net: openvswitch: fix overwriting ct original tuple f=
or ICMPv6
      CVE-2024-38559: scsi: qedf: Ensure the copied buf is NUL terminated
      CVE-2024-38560: scsi: bfa: Ensure the copied buf is NUL terminated
      CVE-2024-38565: wifi: ar5523: enable proper endpoint verification
      CVE-2024-38567: wifi: carl9170: add a proper sanity check for endpoin=
ts
      CVE-2024-38578: ecryptfs: Fix buffer size for tag 66 packet
      CVE-2024-38579: crypto: bcm - Fix pointer arithmetic
      CVE-2024-38582: nilfs2: fix potential hang in nilfs_detach_log_writer=
()
      CVE-2024-38583: nilfs2: fix use-after-free of timer for log writer th=
read
      CVE-2024-38586: r8169: Fix possible ring buffer corruption on fragmen=
ted Tx packets.
      CVE-2024-38587: speakup: Fix sizeof() vs ARRAY_SIZE() bug
      CVE-2024-38589: netrom: fix possible dead-lock in nr_rt_ioctl()
      CVE-2024-38590: RDMA/hns: Modify the print level of CQE error
      CVE-2024-38596: af_unix: Fix data races in unix_release_sock/unix_str=
eam_sendmsg
      CVE-2024-38597: eth: sungem: remove .ndo_poll_controller to avoid dea=
dlocks
      CVE-2024-38598: md: fix resync softlockup when bitmap size is less th=
an array size
      CVE-2024-38599: jffs2: prevent xattr node from overflowing the eraseb=
lock
      CVE-2024-38601: ring-buffer: Fix a race between readers and resize ch=
ecks
      CVE-2024-38605: ALSA: core: Fix NULL module pointer assignment at car=
d init
      CVE-2024-38607: macintosh/via-macii: Fix "BUG: sleeping function call=
ed from invalid context"
      CVE-2024-38612: ipv6: sr: fix invalid unregister error path
      CVE-2024-38613: m68k: Fix spinlock race in kernel thread creation
      CVE-2024-38615: cpufreq: exit() callback is optional
      CVE-2024-38618: ALSA: timer: Set lower bound of start tick time
      CVE-2024-38619: usb-storage: alauda: Check whether the media is initi=
alized
      CVE-2024-38621: media: stk1160: fix bounds checking in stk1160_copy_v=
ideo()
      CVE-2024-38627: stm class: Fix a double free in stm_register_device()
      CVE-2024-38633: serial: max3100: Update uart_driver_registered on dri=
ver removal
      CVE-2024-38634: serial: max3100: Lock port->lock when calling uart_ha=
ndle_cts_change()
      CVE-2024-38635: soundwire: cadence: fix invalid PDI offset
      CVE-2024-38637: greybus: lights: check return of get_channel_from_mod=
e
      CVE-2024-38659: enic: Validate length of nl attributes in enic_set_vf=
_port
      CVE-2024-38661: s390/ap: Fix crash in AP internal function modify_bit=
map()
      CVE-2024-38662: bpf: Allow delete from sockmap/sockhash only if updat=
e is allowed
      CVE-2024-38780: dma-buf/sw-sync: don't enable IRQ from sync_print_obj=
()
      CVE-2024-39276: ext4: fix mb_cache_entry's e_refcnt leak in ext4_xatt=
r_block_cache_find()
      CVE-2024-39292: um: Add winch to winch_handlers before registering wi=
nch IRQ
      CVE-2024-39301: net/9p: fix uninit-value in p9_client_rpc()
      CVE-2024-39467: f2fs: fix to do sanity check on i_xattr_nid in sanity=
_check_inode()
      CVE-2024-39468: smb: client: fix deadlock in smb2_find_smb_tcon()
      CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long lo=
op on I/O errors
      CVE-2024-39471: drm/amdgpu: add error handle to avoid out-of-bounds
      CVE-2024-39475: fbdev: savage: Handle err return when savagefb_check_=
var failed
      CVE-2024-39476: md/raid5: fix deadlock that raid5d() wait for itself =
to clear MD_SB_CHANGE_PENDING
      CVE-2024-39480: kdb: Fix buffer overflow during tab-complete
      CVE-2024-39482: bcache: fix variable length array abuse in btree_iter
      CVE-2024-39484: mmc: davinci: Don't strip remove function when driver=
 is builtin
    added commits:
      CIP: Bump version suffix to -cip50 after merge from stable
      cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_c=
ache_wback()
      riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt proper=
ties from ETH0/1 nodes
      arm64: dts: renesas: r9a07g043: Move interrupt-parent property to com=
mon DTSI
      riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
      irqchip/renesas-rzg2l: Reorder function calls in rzg2l_irqc_irq_disab=
le()
      irqchip/renesas-rzg2l: Add support for RZ/Five SoC
      irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Fi=
ve SoC
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interru=
pts
      clk: renesas: rzg2l: Fix build warning
      drm/amdgpu/virt: fix handling of the atomic flag
      arm64: defconfig: Enable Renesas RZ/G2L display unit DRM driver
      arm64: dts: renesas: rzg2l-smarc: Enable DU and link with DSI
      Revert "arm64: dts: renesas: Drop ADV7535 IRQ"
      arm64: dts: renesas: r9a07g054: Add DU node
      arm64: dts: renesas: r9a07g044: Add DU node
      drm: renesas: Add RZ/G2L DU Support
      dt-bindings: display: renesas,rzg2l-du: Document RZ/V2L DU bindings
      dt-bindings: display: Document Renesas RZ/G2L DU bindings
      drm/crtc: Introduce drmm_crtc_init_with_planes
      drm/crtc: add drmm_crtc_alloc_with_planes()
      drm/plane: add drmm_universal_plane_alloc()
      drm: add drmm_encoder_alloc()
      drm: Allow const struct drm_driver
      drm: Place Renesas drivers in a separate dir
      arm64: dts: renesas: r9a07g0{43,44,54}: Update RZ/G2L family compatib=
le
      usb: renesas_usbhs: Remove trailing comma in the terminator entry for=
 OF table
      usb: renesas_usbhs: Update usbhs pipe configuration for RZ/G2L family
      usb: renesas_usbhs: Improve usbhsc_default_pipe[] for isochronous tra=
nsfers
      usb: renesas_usbhs: Simplify obtaining device data
      dt-bindings: usb: renesas,usbhs: Document RZ/G2L family compatible
      dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
      arm64: dts: renesas: rzg2l: Add missing interrupts to IRQC nodes
      arm64: dts: renesas: r9a08g045: Add PSCI support
      arm64: dts: renesas: r9a08g045: Add missing interrupts to IRQC node
      arm64: dts: renesas: rzg3s-smarc: Add gpio keys
      arm64: dts: renesas: r9a08g045: Add IA55 interrupt controller node
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G3=
S
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/G2=
UL SoC
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update descrip=
tion for '#interrupt-cells' property
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/V2=
L SoC
      irqchip/renesas-rzg2l: Add support for suspend to RAM
      pinctrl: renesas: rzg2l: Add suspend/resume support
      pinctrl: renesas: rzg2l: Avoid configuring ISEL in gpio_irq_{en,dis}a=
ble*(
      pinctrl: renesas: rzg2l: Simplify rzg2l_gpio_irq_{en,dis}able()
      pinctrl: renesas: rzg2l: Configure interrupt input mode
      pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
      pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK() mac=
ro
      pinctrl: renesas: rzg2l: Improve code for readability
      bitfield: add FIELD_PREP_CONST()
      clk: renesas: r9a08g045: Add IA55 pclk and its reset

  v6.1.96-cip24:
    repository:
      https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
    branch:
      linux-6.1.y-cip
    commit hash:
      30eabd096d28d66c597dc50705a373a0c7eda4bf
    Fixed CVEs:
      CVE-2024-36894: usb: gadget: f_fs: Fix race between aio_cancel() and =
AIO request complete
      CVE-2024-36973: misc: microchip: pci1xxxx: fix double free in the err=
or handling of gp_aux_bus_probe()
      CVE-2024-36974: net/sched: taprio: always validate TCA_TAPRIO_ATTR_PR=
IOMAP
      CVE-2024-36978: net: sched: sch_multiq: fix possible OOB write in mul=
tiq_tune()
      CVE-2024-37078: nilfs2: fix potential kernel bug due to lack of write=
back flag waiting
      CVE-2024-38619: usb-storage: alauda: Check whether the media is initi=
alized
      CVE-2024-39298: mm/memory-failure: fix handling of dissolved but not =
taken off from buddy pages
      CVE-2024-39362: [REJECTED]: i2c: acpi: Unbind mux adapters before del=
ete
      CVE-2024-39371: io_uring: check for non-NULL file pointer in io_file_=
can_poll()
      CVE-2024-39469: nilfs2: fix nilfs_empty_dir() misjudgment and long lo=
op on I/O errors
      CVE-2024-39474: mm/vmalloc: fix vmalloc which may return null if call=
ed with __GFP_NOFAIL
      CVE-2024-39484: mmc: davinci: Don't strip remove function when driver=
 is builtin
    added commits:
      CIP: Bump version suffix to -cip24 after merge from stable
      net: ravb: Fix GbEth jumbo packet RX checksum handling
      cache: ax45mp_cache: Align end size to cache boundary in ax45mp_dma_c=
ache_wback()
      riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt proper=
ties from ETH0/1 nodes
      arm64: dts: renesas: r9a07g043: Move interrupt-parent property to com=
mon DTSI
      riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
      irqchip/renesas-rzg2l: Reorder function calls in rzg2l_irqc_irq_disab=
le()
      irqchip/renesas-rzg2l: Add support for RZ/Five SoC 65;6203;1c commit =
d011c022efe275791897668aa421e2db9f2e6450 upstream.
      irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document RZ/Fi=
ve SoC
      dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update interru=
pts

Best regards,
   Nobuhiro




