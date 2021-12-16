Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34900C433EF
	for <webhook@archiver.kernel.org>; Thu, 16 Dec 2021 05:27:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.6424.1639632427105920248
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Dec 2021 21:27:09 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1BG5R3bw022970;
 Thu, 16 Dec 2021 14:27:03 +0900
X-Iguazu-Qid: 2wHHj7UJ06m1nHTZk9
X-Iguazu-QSIG: v=2; s=0; t=1639632423; q=2wHHj7UJ06m1nHTZk9;
 m=T8VTzWNmAvEtcAl9cHAQIgZGYa8xAoR+LML2oi4xEj4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 1BG5R2EJ016747
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 16 Dec 2021 14:27:02 +0900
Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 21C0D1002ED
	for <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 14:27:02 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1BG5Qw3O028141
	for <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 14:27:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgjLItnjEU+5b85P1DN8ssCTB7NM8YyHmfPDknRyC6o6xu66JrHapVbOQlAXkLw7SQBLp0qS4hdtwAS1VjgatHqu8x22p1h8U4P2P05M4D9kY2xLEvQ0zof32Y3HlgkdJXJ/KyDzFSsPqPGjebEyGxEGiFYvF+3PIzuv9iNVAQS04O2+MOh/3EuJmInPlG/kpXT4ViAZ+4k5rNoql9OwzhwXZ7ve/rSkAMixPfcOdbKa+2D4J6KTb2RaMnPV4GAHj1M64TyG29VNE1wHCjfu4zeTc7Kpk5ZtbmItnJbJM9rSBrZtpqHac/jY2kON5tFXE7jJUPpvfBR03SQWzcmPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/J0M+gMXJnhAC7/zPQrhI9QMSQvrcaymrTRUnSH/H/Q=;
 b=IATr6UAgcjXfYFMxpBYTv21MMZOdVCMfH3/IUVQuPK7YEUFPz69Au41d5IisTjV0hhAbwyvlu9w/Je2oFss3CzbEjMGcBx+KY4ba3YzzPzwMfKKvX1ptG42Az7UD5nxi49MIvgy23cba/2N/YD66EX9Yh/j5ttfvatsWKuLi0E/c4ViUmVQ4AMPgHC3gFyRmPPDY2kBEFWEaZavQfG0+sVrNUxnkO/vjrbcSS0ll444JVHuRZg69hGMh/CAQvnjDBCKbb7EvTSLadWT/YBDmevVSKV2/Uevu9Ihtut7Qst0IeIOHWtq9jdj3wPl+LawDuJijjuiPv1GocJj8XXuQhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: Re: [cip-dev] New CVE entries in this week
Thread-Topic: [cip-dev] New CVE entries in this week
Thread-Index: AQHX8g6i7OGLzMqRxUCEKsknskLICaw0lmyU
Date: Thu, 16 Dec 2021 05:26:59 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62525566919A2925279299FD92779@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <CAODzB9rdc7X0n9nEi9JKzQmjuVbreaosKpHcn7YYpyGPSWkPQg@mail.gmail.com>
In-Reply-To: 
 <CAODzB9rdc7X0n9nEi9JKzQmjuVbreaosKpHcn7YYpyGPSWkPQg@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 5d7fde43-00d3-faeb-ca4a-800c5a9121bc
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f28c1735-c199-4588-6050-08d9c054af13
x-ms-traffictypediagnostic: TYAPR01MB5481:EE_
x-microsoft-antispam-prvs: 
 <TYAPR01MB5481A308F3EA6D23D18BCA9E92779@TYAPR01MB5481.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:269;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 U49EthOriZPF+jm5mNw3AqxXk3RCsd/nRYFbQWb66IrVAX+GGOfpTh+f1+q9eBYP4pkk1CfvlHycptXgiqSTaGwr8tFOn/dgHYt5UeIGJnzKwGoILaKQoOvVGrgLtEx34Re0TdA+2kmAHhtbdlx7DH43tJtRT7D5RaczlRAmXl1UHlm8uHTx8GHzDtw28aVd41Rf03PpeUNl7tf0FOatFiEsPoEBeN436pFmjVon62zYVwBGKpCErZ3kd44XEVx5Dze2ohVu7+TiwkmGbYharWVYvIccFOpHmu89/aRT90s+tJOU+6oYvdS+5BdEyVRTKoeBAyTNMn9JbxkPPEXegHXtC5BVTxhPg/PVMqQAO9yVmanNnccs83jQV+czdNwCqzppySEZlICcrXi3rzkJU6LC2kCrKCslCEZFnIUi1AZY4c/JQRiJvkdkp2FkTMclBMtOMpwJ+4xopSqzrB66THAy0FgkcyumD5E6VfSyV6aqYPFTFIa8zUJH340qRygi3klLdSm+pdE0vnFNtKQinZUQamPWettlFmLFikQs9viU5H4Ta3sCk+59Ddb4jss3DhBxWljXlMy4k8wq2W95XVF2IRn572FPP9NOTDJIlDLj74LIRNFJQ7rnL3ITRlwS54e8jcg8hMh5+kuBKrH3X80DKDBTZNbhb9KaBVqy6Hrp9CLcxuEZ8oIqVF+54Ey0YL9mpvRuKasMz6aqh/I6ZoFzWZIfmoWiBwqSk4+N8Psxt1qK/mT6Rh8ZU8pwtb61uisW/lX/1Vtv/1WxouoONEIR5g7Kj7vBC6DLvtpOFEE=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(9686003)(508600001)(86362001)(2906002)(38070700005)(966005)(186003)(6506007)(52536014)(8936002)(99936003)(71200400001)(55016003)(83380400001)(66446008)(64756008)(8676002)(316002)(76116006)(66476007)(7696005)(66946007)(66556008)(6916009)(5660300002)(122000001)(38100700002)(33656002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?U1plNHptV01xVkJHeENPSExpcVkyT0dFQlZod3B5M1pnaVkrZ2xhcHR1?=
 =?iso-2022-jp?B?WVZaYXpkTzlTK2l0ZCtGZFFRK3VmSTVQMDYrcmJQdWdiMWRNb3Y0VDZF?=
 =?iso-2022-jp?B?VjlwbjVvOWsvYzk0a2FoeVFvQVJ2b29rYTRTNDZ4UWtLeHd5YmxKNXFo?=
 =?iso-2022-jp?B?b3hjNHlTMCtvT1RseWhjNVdpQTFYNjA3NVBSTkJkbU50UDQvK1FEWFhs?=
 =?iso-2022-jp?B?aEVobU95b29lWG9UUWhWaVBNTlN4dGw3aTN1K0ZBK3BlVmVEaEtUZFVS?=
 =?iso-2022-jp?B?TG5tN2NlYjJpT1BpUTBNb085Q2hBTCs5OXVON01EQ2xiRndlem5KS2RC?=
 =?iso-2022-jp?B?aGE5Y0J2NDVHd2d0aGEyK3pDckE0blFSMzZvSVdhNXQxWk0rL0VzUTh1?=
 =?iso-2022-jp?B?UHl0anVSYnQ3dDRKV1A3ZjZvYkJTNnR0d3dNbEZCSGZ1cVFKWmlPVDZQ?=
 =?iso-2022-jp?B?ZHErenNycUpDWS9YRVZ2L1F3MU1RYVJ4bGRaL081bXJyVGJ3OGp6eEJ1?=
 =?iso-2022-jp?B?TXRhSk9hS1grMDBKbHBhVFV0STVRanVOdFgvUlJYdXdqZmc0N1VlbERt?=
 =?iso-2022-jp?B?Qk05QS94TnNPazd3K2NZVkovaWxpQ3UyMWd0T0VwQTRwUjJuQUdaZGZu?=
 =?iso-2022-jp?B?M01kWWNYZUNzY1ArSEpRNVhjdlRIUmF1dlNENzRhalNHV2txVmNWQ1Vw?=
 =?iso-2022-jp?B?RDNINmkxRGJKbjRWUjNJMzhsTld0UDV6Tk9BNWEyaTZwa2J5YUxZck9Q?=
 =?iso-2022-jp?B?bWs5UElGYjIwMUVLd0d5eFkyNnlIa2F0b0pYQnBaODIvWnFYSFRDRnNr?=
 =?iso-2022-jp?B?TFMweU1oOVJaOUVpdlRSSnB5VUZBdElvV2tWQUNSbkVIWXNDeU40Z1NH?=
 =?iso-2022-jp?B?eittM1NLbllLMGs5RXpvalA4aWxJQ1B3c2tMNE1HYzRDUWUrS092WVh0?=
 =?iso-2022-jp?B?L1VPeHZnQlUwWjVrdmVNZGp6eHJhYlZZdU1HTlZKUHZDNUd2UWh2THl0?=
 =?iso-2022-jp?B?YitIMG9xZ1VLcnpaaU4yZHREVDFiaHZ0SmpSTnhwaVY3Y0VvWjhiNTRl?=
 =?iso-2022-jp?B?d0RQK0xyd0VuT1AvazM1VUJTUVc5QUNQK2hrSWpvTHk0RTkwVEU2Tmoz?=
 =?iso-2022-jp?B?bVFrc29lQS84Vk1rd1RTdWFJWjFLT2R2Q2FXWmNqT01pU2hsM0lYOXB1?=
 =?iso-2022-jp?B?YUsxS2tlUTlBVTRJRWE5aVlNbUZxSjVmQXN3aitGbEExSkU2NmNQbEpY?=
 =?iso-2022-jp?B?SmppOUs2Q0hZQlQ0TXpmazQyOS9MSTUzZ2RjbytRS2FnczVxUE5DU2wx?=
 =?iso-2022-jp?B?aCtaZWw4aHU1Zmw0WVhORXhIWTh4a3ZITzRreDcyeEdQTWFGS2JQMTNT?=
 =?iso-2022-jp?B?ZTd4aUFtWmF4L3lpeXhZTndPamFSdm5GenIzQTVQdTZVblRLL2g4T204?=
 =?iso-2022-jp?B?QU5MZHN1V211YzFEZzAvRFRMYjM3dzNrNDVzVmtqZmt4eHcwYWQ3MnVt?=
 =?iso-2022-jp?B?alJONEpRYzBjTUhmSWpxZTVxMHdmZmFKNlUrcjRJRkxiMjYycXhrVnNq?=
 =?iso-2022-jp?B?TmVHTDk2NzlVcWZ3UTNKMTZVUzl4RFlIK0tTRmRWTUo1a2pvZHkwZWh3?=
 =?iso-2022-jp?B?aTNmdEdCWjNqL1hpNVRUYi91Zy9lRDE5M2cvWmZTRzhZa0VvajA0VFIy?=
 =?iso-2022-jp?B?ZnZWak93UG84Ujh5dFVPdHI4OC9nWXdPWUFoRUZBWDJCdGNhd2Rsb0Qv?=
 =?iso-2022-jp?B?SkY1Z08wMndrNTNLV1JBRDR4QjcwVlNEWnR1Ui85Y29teEFVRzNYTjND?=
 =?iso-2022-jp?B?ZUVpVnRHOVpGaWhsNEllZldlN0g0N2NFUlI3T0QzWWZGU3p2bGhqRHNR?=
 =?iso-2022-jp?B?bUViV0VpMVVQckhSbUlReTR4bVNLT3kydExmMUR6VHJSSXlaNE5OaEp3?=
 =?iso-2022-jp?B?djVjNDB3aHZVOHUxcTJUMGp2TmFpREZpelVFZ0sxQ2k0WXVlT3hTVHV3?=
 =?iso-2022-jp?B?SHJyNnMzTFhsWlpNVUNWRUZOeXV6WG9vYnZrUllQZjZkekp1TW1zcUhD?=
 =?iso-2022-jp?B?RFV2TWJOYmVyVHBPS01KSkFwYlZ6dXhCUmViNi9MemEvYUhRbERsUU9B?=
 =?iso-2022-jp?B?SnQ4c0VhMjlCUzBYenhyeE14L3BDUkJUR1lHa2hiQ0s5N3htQ1RLeHAy?=
 =?iso-2022-jp?B?RUJWd2ZOSXdFVVRFN09GcEF5bjNFeFh4OHBNTkRHVml3RktUZ1h0ZGNU?=
 =?iso-2022-jp?B?MEhLME82ZWEvRzRwSzZiZDdiaUJzOWg4a2JzQy8waEkvMmFkZnFxWGh2?=
 =?iso-2022-jp?B?dXM3clhmVVR3MisrcUdmYjhhZzcrNERtR0Z1b0dybzBlMGRWMnJtZmln?=
 =?iso-2022-jp?B?elRFaXYyRVZRTGhLYjNlT0ZuYzRCcTNxNEVUN1dua09zaS9LSHpNSVZF?=
 =?iso-2022-jp?B?ZUVUYTRCRERnNXNPc29KMFdOaFhUZXRZKzN0ZkxkdG1teUZYQnEvczJC?=
 =?iso-2022-jp?B?RmgwQXRF?=
Content-Type: multipart/mixed;
	boundary="_002_TYAPR01MB62525566919A2925279299FD92779TYAPR01MB6252jpnp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f28c1735-c199-4588-6050-08d9c054af13
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2021 05:26:59.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 RwJZHUoRbeHnPJ0yor2G1hlGEkWHoN7SzX3leF2wvLFoNVAtt4HR6lRmt/bqTbbpevku5Kjt1pRZv3d35c4oRfG2GYUItSr062pjtGqER2FhbehSp2uBJFMRVaWEwwpL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5481
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 16 Dec 2021 05:27:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7114

--_002_TYAPR01MB62525566919A2925279299FD92779TYAPR01MB6252jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi,=0A=
=0A=
> CVE-2021-39648: usb: gadget: configfs: Fix use-after-free issue with udc_=
name=0A=
> =0A=
> CVSS v3 score is not provided=0A=
> =0A=
> 4.4 kernel gadget_dev_desc_UDC_show() is bit different from later=0A=
> kernel versions. However, it looks 4.4 also has same issue.=0A=
> =0A=
> Fixed status=0A=
> =0A=
> mainline: [64e6bbfff52db4bf6785fab9cffab850b2de6870]=0A=
> stable/4.14: [6766064c794afeacc29b21fc09ea4dbe3cae1af3]=0A=
> stable/4.19: [83b74059fdf1c4fa6ed261725e6f301552ad23f7]=0A=
> stable/4.9: [225330e682fa9aaa152287b49dea1ce50fbe0a92]=0A=
> stable/5.10: [a4b202cba3ab1a7a8b1ca92603931fba5e2032c3]=0A=
> stable/5.4: [bcffe2de9dde74174805d5f56a990353e33b8072]=0A=
=0A=
I created a patch which revise this issue. I attached this mail.=0A=
=0A=
Best regards,=0A=
  Nobuhiro=0A=
________________________________________=0A=
=1B$B:9=3DP?M=1B(B: cip-dev@lists.cip-project.org <cip-dev@lists.cip-projec=
t.org> =1B$B$,=1B(B Masami Ichikawa <masami.ichikawa@miraclelinux.com> =1B$=
B$NBeM}$GAw?.=1B(B=0A=
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B16=1B$BF|=1B(B 8:49=0A=
=1B$B08@h=1B(B: cip-dev=0A=
=1B$B7oL>=1B(B: [cip-dev] New CVE entries in this week=0A=
=0A=
Hi !=0A=
=0A=
It's this week's CVE report.=0A=
=0A=
This week reported ten new CVEs and two of them aren't fixed in the=0A=
mainline yet.=0A=
=0A=
* New CVEs=0A=
=0A=
CVE-2021-0961: In quota_proc_write of xt_quota2.c, there is a possible=0A=
way to read kernel memory due to uninitialized data=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
This bug is fixed in Android kernel. There is three commits to fix this bug=
.=0A=
=0A=
https://android.googlesource.com/kernel/common/+/e113eb454e92=0A=
https://android.googlesource.com/kernel/common/+/60a4c35570d9=0A=
https://android.googlesource.com/kernel/common/+/4b05a506bda0=0A=
=0A=
These commit modified net/netfilter/xt_quota2.c which is Android=0A=
specific source. So this CVE is Android specific bug. The mainline and=0A=
stable kernels aren't affected.=0A=
=0A=
Fixed status=0A=
=0A=
The mainline and stable kernels aren't affected.=0A=
=0A=
CVE-2021-39648: usb: gadget: configfs: Fix use-after-free issue with udc_na=
me=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
4.4 kernel gadget_dev_desc_UDC_show() is bit different from later=0A=
kernel versions. However, it looks 4.4 also has same issue.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [64e6bbfff52db4bf6785fab9cffab850b2de6870]=0A=
stable/4.14: [6766064c794afeacc29b21fc09ea4dbe3cae1af3]=0A=
stable/4.19: [83b74059fdf1c4fa6ed261725e6f301552ad23f7]=0A=
stable/4.9: [225330e682fa9aaa152287b49dea1ce50fbe0a92]=0A=
stable/5.10: [a4b202cba3ab1a7a8b1ca92603931fba5e2032c3]=0A=
stable/5.4: [bcffe2de9dde74174805d5f56a990353e33b8072]=0A=
=0A=
CVE-2021-39656: configfs: fix a use-after-free in __configfs_open_file=0A=
=0A=
Bug introduced commit b0841ee was merged in 5.3-rc8. This commit isn't=0A=
backported to 4.4 so 4.4 isn't affected.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [14fbbc8297728e880070f7b077b3301a8c698ef9]=0A=
stable/4.14: [4769013f841ed35bdce3b11b64349d0c166ee0a2]=0A=
stable/4.19: [9123463620132ada85caf5dc664b168f480b0cc4]=0A=
stable/4.9: [6f5c47f0faed69f2e78e733fb18261854979e79f]=0A=
stable/5.10: [109720342efd6ace3d2e8f34a25ea65036bb1d3b]=0A=
stable/5.4: [73aa6f93e1e980f392b3da4fee830b0e0a4a40ff]=0A=
=0A=
CVE-2021-39657: scsi: ufs: Correct the LUN used in=0A=
eh_device_reset_handler() callback=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
Bug was fixed in 5.11-rc4. so mainline and stable kernels are already fixed=
.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [35fc4cd34426c242ab015ef280853b7bff101f48]=0A=
stable/4.14: [30f2a89f9481f851bc68e51a1e7114392b052231]=0A=
stable/4.19: [b397fcae2207963747c6f947ef4d06575553eaef]=0A=
stable/4.4: [a4cdbf4805bfed8f39e6b25f113588064d9a6ac5]=0A=
stable/4.9: [7bbac19e604b2443c93f01c3259734d53f776dbf]=0A=
stable/5.10: [2536194bb3b099cc9a9037009b86e7ccfb81461c]=0A=
stable/5.4: [97853a7eae80a695a18ce432524eaa7432199a41]=0A=
=0A=
CVE-2021-4090: kernel: Overflow of bmval[bmlen-1] in=0A=
nfsd4_decode_bitmap function=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
OOB write bug in nsfd. This bug was introduced by commit d1c263a=0A=
("NFSD: Replace READ* macros in nfsd4_decode_fattr()=0A=
") since 5.11-rc1 and fixed in 5.16-rc2. Before 5.11 kernels aren't=0A=
affected this issue.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [c0019b7db1d7ac62c711cda6b357a659d46428fe]=0A=
stable/5.15: [10c22d9519f3f5939de61a1500aa3a926b778d3a]=0A=
=0A=
CVE-2021-4093: KVM: SVM: out-of-bounds read/write in sev_es_string_io=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
OOB read/write bug in AMD SVM mode. This bug was introduced by commit=0A=
7ed9abf ("KVM: SVM: Support string IO operations for an SEV-ES guest")=0A=
which is merged since 5.11-rc1. Before 5.11 kernels aren't affected=0A=
this issue.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [95e16b4792b0429f1933872f743410f00e590c55]=0A=
=0A=
CVE-2021-4095: KVM: NULL pointer dereference in kvm_dirty_ring_get()=0A=
in virt/kvm/dirty_ring.c=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
This issues was introduced by commit 629b534 ("KVM: x86/xen: update=0A=
wallclock region") which is merged in 5.12-rc1-dontuse. Before=0A=
5.12-rc1-dontuse kernels aren't affectd this issue.=0A=
Patch is being reviewed.=0A=
=0A=
Fixed status=0A=
=0A=
Not fixed yet.=0A=
=0A=
CVE-2021-3864: descendant's dumpable setting with certain SUID binaries=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
This bug is able to write coredump file anyware. However, abusing this=0A=
bug, such as arbitrary code execution is required some program. The=0A=
PoC(https://www.openwall.com/lists/oss-security/2021/10/20/2).=0A=
There is two mitigation techniques are suggested. So, users follow=0A=
these mitigation technique is recommended.=0A=
=0A=
Fixed status=0A=
=0A=
Not fixed yet.=0A=
=0A=
CVE-2021-4083: fget: check that the fd still exists after getting a ref to =
it=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
UAF bug in fs/file.c it causes system crash, priviledge escalation.=0A=
The mainline and all stable kernels are aready fixed.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [054aa8d439b9185d4f5eb9a90282d1ce74772969]=0A=
stable/4.14: [98548c3a9882a1ea993a103be7c1b499f3b88202]=0A=
stable/4.19: [8bf31f9d9395b71af3ed33166a057cd3ec0c59da]=0A=
stable/4.4: [8afa4ef999191477506b396fae518338b8996fec]=0A=
stable/4.9: [a043f5a600052dc93bc3d7a6a2c1592b6ee77482]=0A=
stable/5.10: [4baba6ba56eb91a735a027f783cc4b9276b48d5b]=0A=
stable/5.15: [6fe4eadd54da3040cf6f6579ae157ae1395dc0f8]=0A=
stable/5.4: [03d4462ba3bc8f830d9807e3c3fde54fad06e2e2]=0A=
=0A=
CVE-2021-39685: Linux Kernel USB Gadget buffer overflow=0A=
=0A=
CVSS v3 score is not provided=0A=
=0A=
Buffer overflow bug in USB gadget devices. An attacker can read and/or=0A=
write up to 65k of kernel memory.=0A=
It already fixed in mainline and all stable kernels.=0A=
=0A=
Fixed status=0A=
=0A=
mainline: [153a2d7e3350cc89d406ba2d35be8793a64c2038,=0A=
86ebbc11bb3f60908a51f3e41a17e3f477c2eaa3]=0A=
stable/4.14: [e7c8afee149134b438df153b09af7fd928a8bc24,=0A=
d8cd524ae4ec788011a14be17503fc224f260fe3]=0A=
stable/4.19: [13e45e7a262dd96e8161823314679543048709b9,=0A=
32de5efd483db68f12233fbf63743a2d92f20ae4]=0A=
stable/4.4: [93cd7100fe471c5f76fb942358de4ed70dbcaf35,=0A=
af21211c327c4703c7681fa7286c4d660682e413]=0A=
stable/4.9: [d2ca6859ea96c6d4c6ad3d6873a308a004882419,=0A=
e4de8ca013f06ad4a0bf40420a291c23990e4131]=0A=
stable/5.10: [7193ad3e50e596ac2192531c58ba83b9e6d2444b,=0A=
e4de8ca013f06ad4a0bf40420a291c23990e4131]=0A=
stable/5.15: [36dfdf11af49d3c009c711fb16f5c6e7a274505d,=0A=
6eea4ace62fa6414432692ee44f0c0a3d541d97a]=0A=
stable/5.4: [fd6de5a0cd42fc43810bd74ad129d98ab962ec6b,=0A=
9978777c5409d6c856cac1adf5930e3c84f057be]=0A=
=0A=
* Updated CVEs=0A=
=0A=
no updated CVEs.=0A=
=0A=
Currently tracking CVEs=0A=
=0A=
CVE-2021-31615: Unencrypted Bluetooth Low Energy baseband links in=0A=
Bluetooth Core Specifications 4.0 through 5.2=0A=
=0A=
There is no fix information.=0A=
=0A=
CVE-2020-26555: BR/EDR pin code pairing broken=0A=
=0A=
No fix information=0A=
=0A=
CVE-2020-26556: kernel: malleable commitment Bluetooth Mesh Provisioning=0A=
=0A=
No fix information.=0A=
=0A=
CVE-2020-26557: kernel: predictable Authvalue in Bluetooth Mesh=0A=
Provisioning Leads to MITM=0A=
=0A=
No fix information.=0A=
=0A=
CVE-2020-26559: kernel: Authvalue leak in Bluetooth Mesh Provisioning=0A=
=0A=
No fix information.=0A=
=0A=
CVE-2020-26560: kernel: impersonation attack in Bluetooth Mesh Provisioning=
=0A=
=0A=
No fix information.=0A=
=0A=
=0A=
Regards,=0A=
--=0A=
Masami Ichikawa=0A=
Cybertrust Japan Co., Ltd.=0A=
=0A=
Email :masami.ichikawa@cybertrust.co.jp=0A=
          :masami.ichikawa@miraclelinux.com=0A=

--_002_TYAPR01MB62525566919A2925279299FD92779TYAPR01MB6252jpnp_
Content-Type: application/octet-stream;
	name="0001-usb-gadget-configfs-Fix-use-after-free-issue-with-ud.patch"
Content-Description: 
 0001-usb-gadget-configfs-Fix-use-after-free-issue-with-ud.patch
Content-Disposition: attachment;
	filename="0001-usb-gadget-configfs-Fix-use-after-free-issue-with-ud.patch";
	size=2459; creation-date="Thu, 16 Dec 2021 05:26:43 GMT";
	modification-date="Thu, 16 Dec 2021 05:26:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSA4ZDM0OTU2ZWQyYzkyNDdmMWJiYmY2M2ZkMWIwMDAwYWZkMWZhYWVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFZGRpZSBIdW5nIDxlZGRpZS5odW5nQG1lZGlhdGVrLmNvbT4K
RGF0ZTogVHVlLCAyOSBEZWMgMjAyMCAxODo1MzozNSArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIHVz
YjogZ2FkZ2V0OiBjb25maWdmczogRml4IHVzZS1hZnRlci1mcmVlIGlzc3VlIHdpdGggdWRjX25h
bWUKCmNvbW1pdCA2NGU2YmJmZmY1MmRiNGJmNjc4NWZhYjljZmZhYjg1MGIyZGU2ODcwIHVwc3Ry
ZWFtLgoKVGhlcmUgaXMgYSB1c2UtYWZ0ZXItZnJlZSBpc3N1ZSwgaWYgYWNjZXNzIHVkY19uYW1l
CmluIGZ1bmN0aW9uIGdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUgYWZ0ZXIgYW5vdGhlciBjb250
ZXh0CmZyZWUgdWRjX25hbWUgaW4gZnVuY3Rpb24gdW5yZWdpc3Rlcl9nYWRnZXQuCgpDb250ZXh0
IDE6CmdhZGdldF9kZXZfZGVzY19VRENfc3RvcmUoKS0+dW5yZWdpc3Rlcl9nYWRnZXQoKS0+CmZy
ZWUgdWRjX25hbWUtPnNldCB1ZGNfbmFtZSB0byBOVUxMCgpDb250ZXh0IDI6CmdhZGdldF9kZXZf
ZGVzY19VRENfc2hvdygpLT4gYWNjZXNzIHVkY19uYW1lCgpDYWxsIHRyYWNlOgpkdW1wX2JhY2t0
cmFjZSsweDAvMHgzNDAKc2hvd19zdGFjaysweDE0LzB4MWMKZHVtcF9zdGFjaysweGU0LzB4MTM0
CnByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24rMHg3OC8weDQ3OApfX2thc2FuX3JlcG9ydCsweDI3
MC8weDJlYwprYXNhbl9yZXBvcnQrMHgxMC8weDE4Cl9fYXNhbl9yZXBvcnRfbG9hZDFfbm9hYm9y
dCsweDE4LzB4MjAKc3RyaW5nKzB4ZjQvMHgxMzgKdnNucHJpbnRmKzB4NDI4LzB4MTRkMApzcHJp
bnRmKzB4ZTQvMHgxMmMKZ2FkZ2V0X2Rldl9kZXNjX1VEQ19zaG93KzB4NTQvMHg2NApjb25maWdm
c19yZWFkX2ZpbGUrMHgyMTAvMHgzYTAKX192ZnNfcmVhZCsweGYwLzB4NDljCnZmc19yZWFkKzB4
MTMwLzB4MmI0ClN5U19yZWFkKzB4MTE0LzB4MjA4CmVsMF9zdmNfbmFrZWQrMHgzNC8weDM4CgpB
ZGQgbXV0ZXhfbG9jayB0byBwcm90ZWN0IHRoaXMga2luZCBvZiBzY2VuYXJpby4KClNpZ25lZC1v
ZmYtYnk6IEVkZGllIEh1bmcgPGVkZGllLmh1bmdAbWVkaWF0ZWsuY29tPgpTaWduZWQtb2ZmLWJ5
OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPgpSZXZpZXdlZC1ieTogUGV0
ZXIgQ2hlbiA8cGV0ZXIuY2hlbkBueHAuY29tPgpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpM
aW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzE2MDkyMzkyMTUtMjE4MTktMS1naXQtc2Vu
ZC1lbWFpbC1tYWNwYXVsLmxpbkBtZWRpYXRlay5jb20KU2lnbmVkLW9mZi1ieTogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KW1JlZmVyZW5jZTogQ1ZFLTIw
MjEtMzk2NDhdCltpd2FtYXRzdTogc3RydWN0IHVzYl9nYWRnZXRfZHJpdmVyIGRvZXMgbm90IGhh
dmUgdWRjX25hbWUgdmFyaWFibGUuCiAgICAgICAgICAgQ2hhbmdlIHN0cnVjdCBnYWRnZXRfaW5m
bydzIHVkY19uYW1lLl0KU2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgKENJUCkgPG5v
YnVoaXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwPgotLS0KIGRyaXZlcnMvdXNiL2dhZGdldC9j
b25maWdmcy5jIHwgMTEgKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2NvbmZp
Z2ZzLmMgYi9kcml2ZXJzL3VzYi9nYWRnZXQvY29uZmlnZnMuYwppbmRleCAwZWYzZjRlNDUyNDI4
Yy4uNmUxMTcyNDUwYzczNDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdm
cy5jCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9jb25maWdmcy5jCkBAIC0yNDEsNyArMjQxLDE2
IEBAIHN0YXRpYyBzc2l6ZV90IGdhZGdldF9kZXZfZGVzY19iY2RVU0Jfc3RvcmUoc3RydWN0IGNv
bmZpZ19pdGVtICppdGVtLAogCiBzdGF0aWMgc3NpemVfdCBnYWRnZXRfZGV2X2Rlc2NfVURDX3No
b3coc3RydWN0IGNvbmZpZ19pdGVtICppdGVtLCBjaGFyICpwYWdlKQogewotCXJldHVybiBzcHJp
bnRmKHBhZ2UsICIlc1xuIiwgdG9fZ2FkZ2V0X2luZm8oaXRlbSktPnVkY19uYW1lID86ICIiKTsK
KwlzdHJ1Y3QgZ2FkZ2V0X2luZm8gKmdpID0gdG9fZ2FkZ2V0X2luZm8oaXRlbSk7CisJY2hhciAq
dWRjX25hbWU7CisJaW50IHJldDsKKworCW11dGV4X2xvY2soJmdpLT5sb2NrKTsKKwl1ZGNfbmFt
ZSA9IGdpLT51ZGNfbmFtZTsKKwlyZXQgPSBzcHJpbnRmKHBhZ2UsICIlc1xuIiwgdWRjX25hbWUg
PzogIiIpOworCW11dGV4X3VubG9jaygmZ2ktPmxvY2spOworCisJcmV0dXJuIHJldDsKIH0KIAog
c3RhdGljIGludCB1bnJlZ2lzdGVyX2dhZGdldChzdHJ1Y3QgZ2FkZ2V0X2luZm8gKmdpKQotLSAK
Mi4zNC4xCgo=

--_002_TYAPR01MB62525566919A2925279299FD92779TYAPR01MB6252jpnp_--


