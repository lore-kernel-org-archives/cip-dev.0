Return-Path: <dinesh.kumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127A6C87FCA
	for <webhook@archiver.kernel.org>; Thu, 31 Jul 2025 16:40:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.66982.1753980012416584785
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Jul 2025 09:40:13 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: dinesh.kumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 56VGe9du414288; Fri, 1 Aug 2025 01:40:10 +0900
X-Iguazu-Qid: 2yAbpfLvJze534CLKK
X-Iguazu-QSIG: v=2; s=0; t=1753980009; q=2yAbpfLvJze534CLKK; m=QkobDYlHnMh0BEfzYrYIPdcHc+DwtO2s3lfkiO3GFwE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 56VGe7Y02447796
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 1 Aug 2025 01:40:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUKqL6ujIw4Ap6huhevJI5Qadjebo8qsUOEhbaM8qOI+fwyuP6Pg2OoCy+9StBRAd0qMvMA6TyFgtezjWeD5euDelFC7U+vxEiiC54Av70NhI9bdVVuv6HNza3Bpf9emADZBA9/panq/cJYJKtiPuwzQJngfCXmDoNVLfUJQG8qajZBsgV2s0I2RamEyPk0yPH+erGqwrlkNRa1c3lPGajXNUS/4Q1nq9ANh/m8XTCstwkWZmFrxp0XbOJG+xpWFPTKqgHNDc/nNL6BuGMTmkHzK+XCJ+7KTmMR727rAwOG+NUgncgvrLM7jHxsj2wRu6qAakOBUxQWXTL4/OLXt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r74lvQDECJVehFc5QvG1ciXu8w+Sq/BTK0AdjB5zC/8=;
 b=H5RZkVJmVFkvzaI5tpeelTaq7u8WGMkoJzkHg6eYfcnkT6JiN/8F5E1XfwHSUMuTHpQyLlM4PaUsqZAe5t+EgUPrE+CUeMTZgKDii4dmXvPqDlesGINWRGyl+XqG+BZExD9+wtg5/NiDcE3CJMO+vD9Lv0eCb/kH7dD3qtxAX0+6pNfwIQLUbvrAAB8pD6QOfrmrtN0KSIrILDa4fTGDujgxJBbffZi7bUHW+UKaJKbQM76gRQPiKlSrvVr/Spq4sWDSnj3MzbQcvSJBggGmmcip9RqXh6TYJ2l7pO76oeOxDXARVEUAl/KG2jc1BXqYgaXgLZTYrNYu1THXv6AugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <dinesh.kumar@toshiba-tsip.com>
To: <wwd.smartmachine.stp@posteo.org>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IEC 62443-4-x assessment
Thread-Topic: [cip-dev] CIP IEC 62443-4-x assessment
Thread-Index: AQHcAhUkD0NNva7K4UGCwnurmBEkE7RMbr6w
Date: Thu, 31 Jul 2025 16:40:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OSZPR01MB8515AD1F3AED4FC2F6026A9FBF27A@OSZPR01MB8515.jpnprd01.prod.outlook.com>
References: <f301b512-4775-429d-634a-e5fda909ca8a@posteo.org>
In-Reply-To: <f301b512-4775-429d-634a-e5fda909ca8a@posteo.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8515:EE_|TYYPR01MB16480:EE_
x-ms-office365-filtering-correlation-id: d3d8b532-c154-4771-1c3f-08ddd050e7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R3BZYUg0VThubXRodDVJOXBQQ2gxZlVJdE5VOWYxZGNLRktYbU9sR0VzNVR0?=
 =?utf-8?B?MmJDTllxU0tpbVVkMDVobjhjMEo2MkRJcmdCT2VEVGFhMWpwMENvdm84WnZi?=
 =?utf-8?B?eGRMWGQxaDNXL2ZLTkZxV3NlTkVNZ0V3SjdKcU1EdWJrZmRUdGltRktlTW5w?=
 =?utf-8?B?TmYxbGJrcmRGRzI4Q2REbGhlbXFmZmJyQzlHSnI4YlNidll5cGZPVjl1b0pF?=
 =?utf-8?B?RWpPTnphMFJiOHZzQVVCVUh5d3U2TlBPOUZVYUlEVU5UZ0JaendKYVVHMDN6?=
 =?utf-8?B?Vi9heHVoSHBrSVl3bUJiQnQzTFhvM1AyaFVZOTlCMFVrSWVEUFBDeGZyakY3?=
 =?utf-8?B?OTJRdWFydTVta0ZidXhuOXdxUzJ5YjlwVThrZlN2WFdiMVdhbXE3emtKL3VM?=
 =?utf-8?B?MURmMUJlYzhLVnE3a3hRKzllbnQ3SlBKdHVvVXFnTWc4dHZtZkx0N2NWQUg0?=
 =?utf-8?B?QXp4YVZRa091THFWSmoyVzFlMzVDNDdROWNERU1XQ3E2Z045YXdFZlZLZzM0?=
 =?utf-8?B?QWFDWHl0SHhiYWlIMmdZMklUbmpYWFNSOS9lWHlEY05pTEx6S0VzRjkvU3g2?=
 =?utf-8?B?Z2cvZ3ZDcXNxZHorUnY0WnBqbFh5WnpGRFZtUUFrT01lVWtPQWcyeHZwd0xS?=
 =?utf-8?B?VDRJL1o3QUdabnNQNHJhaFBDTjhib3BDdG8vc2VHbll6UUFBRmErTXdBTVpK?=
 =?utf-8?B?WG41VU1JWUdSaVNFaEV6U3F3QWhBQkcrL3FZSWZ6YmVRVmw0WXpZVUxiRDY0?=
 =?utf-8?B?U0pFZlNmVENCcUgxalhjN3h2SG1LcXJFME5WNlJyamkxcnI2bVVDTEoveHdU?=
 =?utf-8?B?b045QjBWaEVsZ2N1MjA1Qy9ZdUsvWEszMldRT1dNTVRWdHNYOGtTNGljcGtV?=
 =?utf-8?B?dTJRa2pIS1RaM04weDg5UGpRWHFCeVZNR0N1NWdDdC91N1ZYcnZad09ZZndR?=
 =?utf-8?B?WnZnc2hZQ0NxMy9QTGdrSjd0RHVGOTc5SDRqeFEvMm5jTjlwWC94YWtWR3dH?=
 =?utf-8?B?N1NJSUxUWlluN2ZJTW5IYXY0QVNJOUhZdDdSQnkrRFlBMG9Za1BIVWhGWWFY?=
 =?utf-8?B?MmZTRnpGR05FN1M3cjVSY0JiWkZ3QWowRVUvdmU4cDlaMXVtSVdYa1Zmajl6?=
 =?utf-8?B?aXd0eGUyVzhDc0FLZkJ0cGlBWDRNYklGQ09mQXpSVWNVVExrTjRaU2dVaFg3?=
 =?utf-8?B?bXJac0VKRWlDUlE4WUEwMHpSZGUxTjU4aldkaW1ybkJHbFZySG91c3pXWVRN?=
 =?utf-8?B?VU5DbGpMWFBhcWJYelA1OXlXb0QwdlU2ODA1Lzc0YXBXa0JRWnpKMDQ2UzZV?=
 =?utf-8?B?SldSOVZhcjBySWphMWo5eDVBTDl1Wk5WWURPNDBKSGZrcDVIOGRJVUprN2tO?=
 =?utf-8?B?bFZxNnJSWGNVeGd5QUxRcGZxNGNCM0xJa0haaUtvWXVISmZPbFRQVlhBTWU5?=
 =?utf-8?B?RStSeHZPQit1anRxam1VOFJDc2ovbXVRbFRGM0ZEM1loWlJldWRDc3kvS3FM?=
 =?utf-8?B?YnJMNEluYnlHYVNPcWJZZUlTMzF5bjJjdFFSbDFwOG1haUhoQ09KQ3c0akRE?=
 =?utf-8?B?YitweVhDcUNPKzEyU3Zpa0J3R3ZFczE3K1E3NE5EbG42M2MvWC9BM0RkQVM4?=
 =?utf-8?B?TzdKMklzc3JvWHMzdHo3d1NKNG83SmRvbEZVN0RicUkzQXVqa3FIQWJZSlR6?=
 =?utf-8?B?L3QvRERPbWdHSGdJaE1lcDBwUnNCRHZOVTgwZzZPVUMxQ1JWM2czSlBmMWFD?=
 =?utf-8?B?ZU1sVTJyY3kvZkpNZlVURzk4UFNnYThmUWpFWnIyN2hoSU5McmtpeVZCT3c0?=
 =?utf-8?B?QlBabVNCRmFMa1FVVENjUzBNV041LzJhclIzNmdnSVI2RGg4TnMxejJHRktT?=
 =?utf-8?B?aCtUMXZxRnNIR0JQbXhZb2hzbktkWXRuUjJZUjY1SHVEVklEQ0t6UWtQZzRG?=
 =?utf-8?B?VzZ0VU1tSmo2UDh2RTVuVUZNczFaWW1RbUlOZnpvUm5FaWw5dkhvVHhkYjlo?=
 =?utf-8?B?Syswdmt0dFdRPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8515.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?bjd1VXpLc0NSN04wMTJocWU1RXBGdlZzQzNkWE4rUTJzbHFlZisrNTdUTW9D?=
 =?utf-8?B?eWJwSVd1UkpIZnJhYWNpODVOekEwVDdRNnoyT0hhUFQ0WHJYUDNsT3ZyM1Jo?=
 =?utf-8?B?bko3MXppaThwUFlxYWtFT21odTY5aWQvb09FRmQ4WkhOZGlzWERjZUxmNG9H?=
 =?utf-8?B?ZGp2M1lPeGhtTWRDczRURE5sQmMwWDkxMVNuZjJYN3E5a1hoSlgwZnIyZE5O?=
 =?utf-8?B?SkZqcCtOREpDQ3luT1BjV0E3SU9HeFBBejVlTWNDZm9heE9OL2dlZWNnSHBD?=
 =?utf-8?B?RGw4RVYwUGdDM2tkb3BtYXpOSFp4MHdPazV0dnJVUUtOdXBzRXMzQnJmUTc1?=
 =?utf-8?B?ODlsWlRTU0JiL2owaXNtSGg1QVZjOFZMOVpUMU9ya2Q5bTZEMGNHL0puWjZM?=
 =?utf-8?B?c1lQSjVxV0xQYlhZYzFHd3N6OUgxQXZmVmRZMDdIaUxUWnhsU0U4MU1zYXoy?=
 =?utf-8?B?R2F5NzJwOFgvRlUzS1Vud2JBQlR6SWhVb3UwOHFqaGlGSVhUSDM3L2Mza0lN?=
 =?utf-8?B?a0VZYkI4QWVFY3lEZG9pZGtJL3hnR1ErTlNwblZmV1RaY3UyUFg0dXc1RnNs?=
 =?utf-8?B?UFBMUVZDcXErenJCTm15SlVJa2RDeXViR2p2TXJnaFhmeXJtSjVYTVZjVlFM?=
 =?utf-8?B?aXRiVWFDekkzMzJzRWxBVHlmL3JOZm1TUjRCUDhpeGg2RGJSWmRaWlZ5Z0Vt?=
 =?utf-8?B?V2F6bW9XbzUzQ2pSczJUdFhhKys1RnZXd3NsRHdvd3JZWVlDM0tzd0k4YnQx?=
 =?utf-8?B?MXFyOVk5QTg1OTdnLzZldzVsZHFTaDZTRW52UWNURk1Uc2ZaelVINVY3ZWQw?=
 =?utf-8?B?TEtsK1dGQTkxLzB0SjEwSGlGbm1ET3dROGFBNTBOeldvSGJaZWZJbWM3Y3FP?=
 =?utf-8?B?S0NPbndGTU1OOVVQV1FnRXd1b1lOVzVrNi9kUk50OU13b213VGpqTFFkWlgr?=
 =?utf-8?B?WmVIZ1ViVDlHeExTNFNnNytFTm90TXdIOG9TYUIvYk1aRVd0eWdIZU5qTUFH?=
 =?utf-8?B?b0dKOVNEMjlZTVFyenBneDYwYmZnRTVYUDNTdzhmdGF0TzJXNW9VNSszdlZL?=
 =?utf-8?B?ZGpldVpPYlFyb2haUnloOVpEcWZZMkw4d24zb3hzT1d3eWdyQm9mUkZ0MVNt?=
 =?utf-8?B?a3cycm96aVE1RjhBN1grbmNlYzRnZDErSGFSa3JMWk5aZFZSVGdyZkFTK2Y2?=
 =?utf-8?B?MkxDc0RHQW83NldhRTYrQU9CU3lHOTRqQlZRWE9NczF1NWhBZkdOdmV3Vmln?=
 =?utf-8?B?WlJZMk1WcFI1TkdCblJTSWZzeDh1enpzaUQ2YkFwcDRIM1VLTUpOMDhobDR2?=
 =?utf-8?B?N1B1TVQ5KzNzWngvVlZhWjIxcDJXeS85T1htbmh0VGFldjdhQjNnY1pvRHBQ?=
 =?utf-8?B?aXRQdHZsT1hBZE5DVXpTSXhxSVIrYXBuWVZqcWdvaEUyc0N6a1d0SzNsUGJm?=
 =?utf-8?B?R1BLTEFGcEU4MWEvRUZOOTRYbmdBM1Jjb0xLMzFQOTFYLzczMUZ1a01nUm8r?=
 =?utf-8?B?aXhPektvUWwxRWFpbU90bEt2OUJtODdhcXU5REUxQVIvZTB4cnV4OXpsZ243?=
 =?utf-8?B?RUFjOStlbGZlMEpwS29xQVpzSFExYWdYVmlUSklXbEhOUkJFbUJVa2ZTUFhZ?=
 =?utf-8?B?WFpQejhuVHM2Q24vQ1crdjFIM01EWFRZWmZuQ08vMjhBQVhqazdUdkJicU9v?=
 =?utf-8?B?eFdwVVNDc0RWSVBvU29EZUE4VHBOOS8vbTkyUUF4bTE3cS8zOFk2M3lqZ3Ur?=
 =?utf-8?B?ZmIwZ1RGd1lyQ2NVcVVQeE1MWHE4ajEwMFhaWGNhVEpkbjJZbVRoOVl2Q2Ux?=
 =?utf-8?B?c1JDb1Bock5uWVhsekdrTnF5anBJeWJaaUxhekQwMDZRWW5YUitWZ1g2V3N6?=
 =?utf-8?B?MWJQOEdBN0ozdVBiQmt4dFQ4Q2gwMXB2azJBR0h5NlJQT2VsaGdNRDh5TXlx?=
 =?utf-8?B?ZFl0b2hEUkxIK0JNcStMRG9DK20xV21mQ1QwRnN1cEE4dC9ucVFpWWdQT0J6?=
 =?utf-8?B?SmtzZ3FVZ0l3TTlrLzRUcXRTV1FycXpnQVR1L2NHR0FOaDllZThldFZPZVFO?=
 =?utf-8?B?VEpIN1ltTEs3RXU2ZXRDb3RRRGJON1NXY0lVZDc1ZlhvSEZ3RFc0VkJDdmVy?=
 =?utf-8?B?eiszam9WeXdWckE2ZUMvNjJLaitDT0JLeTAvVnFSNTA1ZTM0b09xNFNBRVF6?=
 =?utf-8?B?Rit1WmpwbnplNWZGa1J5L1RvRDR0Wmw3QjB6WjgyV3paTEF2cWZZMGxUeEJP?=
 =?utf-8?B?T2haVVJIUFFxaVZRK3BrRHFYc0d3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8515.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3d8b532-c154-4771-1c3f-08ddd050e7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2025 16:40:05.8862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5C8EB6lHyIV5azGF9ci6cgbDHt+GTAtvWSE1oh2uM62LHO7r8Bv4b3MVJ+qkaB0EyAjXSW4I4EKCiXxDiwsFpJI2s1oiOlz/ZKGY8Y/JAH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB16480
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Jul 2025 16:40:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19649

SGkgV29sZnJhbSwNCg0KQXJlIHlvdSBsb29raW5nIGZvciBhbnkgaW5mb3JtYXRpb24gZm9yIENJ
UCBJRUMtNjI0NDMtNC1YIGFzc2Vzc21lbnQ/DQoNCkknbSBwYXJ0IG9mIENJUCBTZWN1cml0eSB3
b3JrZ3JvdXAsIHBsZWFzZSBmZWVsIGZyZWUgdG8gY29udGFjdCBtZS4NCg0KUmVnYXJkcywNCkRp
bmVzaCBrdW1hcg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogY2lwLWRldkBs
aXN0cy5jaXAtcHJvamVjdC5vcmcgPGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbiBC
ZWhhbGYgT2YgV29sZnJhbSBXYWRlcG9obCB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQpTZW50
OiBUaHVyc2RheSwgSnVseSAzMSwgMjAyNSA1OjQ4IFBNDQpUbzogY2lwLWRldkBsaXN0cy5jaXAt
cHJvamVjdC5vcmcNClN1YmplY3Q6IFtjaXAtZGV2XSBDSVAgSUVDIDYyNDQzLTQteCBhc3Nlc3Nt
ZW50DQoNCkhpLA0Kd2hvIG1heSBJIGNvbnRhY3QgYWJvdXQgdGhpcyB0b3BpYz8NCg0KLS0gDQpX
b2xmcmFtIFdhZGVwb2hsDQpTdG9yb3BhY2sgSGFucyBSZWljaGVuZWNrZXIgR21iSA0K


