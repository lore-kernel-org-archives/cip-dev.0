Return-Path: <kazuhiro3.hayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4111C6FD18
	for <webhook@archiver.kernel.org>; Fri, 31 Mar 2023 12:43:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web10.53655.1680266633392625142
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Mar 2023 05:43:54 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: kazuhiro3.hayashi@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 32VChoiU022928; Fri, 31 Mar 2023 21:43:50 +0900
X-Iguazu-Qid: 2wHHyxo6y7PsOeeIEK
X-Iguazu-QSIG: v=2; s=0; t=1680266629; q=2wHHyxo6y7PsOeeIEK; m=fkIGdmIFYVChG0bE6T5JVEDhJQC7QA6sDWqkPGBCkJ4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1112) id 32VChlv6040588
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 31 Mar 2023 21:43:49 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMq7tKOhTuZ/eJUpuQ1O6XsnY+l6yOyoXuGrd7RHxMe0E1d3jxTPffVPtQnTauL/ySIvlyq4hlmCPwXrWLMW3+1/JDghBuLQ0Tb4NEVA3aVjtJbmts4mvAUU/6tiCMQDga7LlH4Y8q2anzMJ/VYaJVDKDuCAg8orFKiFIPvK2DPPA+hu2i/okIVC78fAVwubDbgqmNf3PCXouyeUx4ecryN7r9eoZEepa0RLwfbbM25BNRFuzota6OMOvMPQRD4KxzSk/ziH1aYgzhMrBVvmbHt9gY9GJ0tXBtBAwsqFMFG8MXnJ4Y6+GxB1QOpmBuf8t8JGo6Z0OxKFkPFVyR8Qzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts7IxdblufEtUTo9MPdOwLosLnlRd4V9NC6O2j38ImM=;
 b=gkNx2ezzOvYaPFxVZ7KDWIFtZnDgtTTXgSK2M1rb133MgflEvA05lO36HVww287TBqswYZXlPGH/1f/CTIvGYgHS2LCRzAp6LzIjOy+plMfV4P/oZCYdUn/6IQFWnhuwYcf1bmGPd0sBLI29vOCRJ616rP6/plbswO8wcVd1ftWHS0AVeuCjQ8rwSj5dJfUQCBtkkCCYKPA2ATQnuxzaDRDLHLdm0ALxAAe/0jDrw/ejZq8UE8EFibzpfqVNd0ovjxqOQ5YgXfsqxV5o0U+Qesle+BnW5ZzWdp41zkwxetrQFYIwRmJr9gHcExvfnz3LFyG68tkwzMIHUWrO8+IcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <kazuhiro3.hayashi@toshiba.co.jp>
To: <hung.tran.jy@renesas.com>, <kento.yoshida.wz@renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: FYI: Building CIP Core image for RZ/G2M
Thread-Topic: FYI: Building CIP Core image for RZ/G2M
Thread-Index: AdljzkkEWZjh/ItoTmO14CZW70m15w==
Date: Fri, 31 Mar 2023 12:42:58 +0000
X-TSB-HOP2: ON
Message-ID: <TYCPR01MB82959D44A625AC0EA5B75542E18F9@TYCPR01MB8295.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8295:EE_|OS3PR01MB8428:EE_
x-ms-office365-filtering-correlation-id: 9276aa65-9770-4c29-21da-08db31e5752e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eQnhmU3xe/I3lU79VAqxQfMUyOFYYhuLlWAcIUkj1vQ2b9TBLlTCDT7Ph4TtFAfFaoee0uC8GH6Vtpxa2N8FKJDYXx5aPjjosLn5gqabyXZK53uBC54WUnIh+hEJcV1+4sPO15iNBK2lbV8lK1irt0Rd7p4tNHFoFFUBnHRvv3eprO0EsjMobbWYbwzvxddIkxbcjrJYGuIul8V72ZdoDaVoRe+XxvpYa186gvtnPkZF3kBPCOORsG6DWPUCvtSOA9Dm+rnnfOpH71NkRGonEHDIPiSqR3PFDspenLDXAtZMn7l0rRgSribKS3HWJeecZ1NYH5RvkLq9EkYtsod+JxxFcSxpZrj5s4jp97pOeZw2X0BSlybFIKLcC5Zqa9D2u3G4y0OTyTy5efDjaQ8LsRbxtYdsh5W0JNFnQ6HmpbK0Vz24HA2Sz+tQhIj6LBboJLJogmDR9si31f1TO/k3glBqYOiYtJ4K58C9Up9/nP6AEySQVD+vWmBknEJ9vNm9EvN+7dpMmaYr7VdCuz16sgXD3fEE34yQ37MXdOQJtJhB8aPAlzaP0BHHf56ugK7USC45dIZOPHkLhkKFzbbxdPPjeWqvwNXdfTu8Z6ARQfg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8295.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(52536014)(64756008)(66946007)(66556008)(86362001)(66476007)(66446008)(4326008)(5660300002)(76116006)(2906002)(55016003)(41300700001)(316002)(478600001)(110136005)(9686003)(8676002)(8936002)(186003)(966005)(71200400001)(26005)(6506007)(33656002)(7696005)(83380400001)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?Mlg1U0tXSEc2RWUxQTBFN0s0VWhUcUQxcys0cjF1YWI2elJZbFdIYk9p?=
 =?iso-2022-jp?B?dDlvQ2x1Nno1OW90cFM1WVVINlRVZVVMLzhnV09sNHA1YXp1UFdiMVBX?=
 =?iso-2022-jp?B?bFp1YzVRVmZBekdHUDRWY3BvczYybi8yM3hER3V6MnVSSk5iK1Y2VnhG?=
 =?iso-2022-jp?B?WmhOSG82ZkgvdGNaOHpOcnBFcmhSUndCTW9QWlYzNFRsMkd0RlNrZEtv?=
 =?iso-2022-jp?B?dHFJTnNLS25vWTRUVzdLenUvNnFJcHozRzRGNU9iVUJQMUZkWUZlWmF1?=
 =?iso-2022-jp?B?WXRBWGo4akVYMkswOUx6YkREVzMzY3lVaFV3U25NNHdyN2I3ay9IVTJ0?=
 =?iso-2022-jp?B?OExkcVNSK0JLMjVsazVtZVFKbmo1VUphVmpZSXdhUEVER2FXT1lCNWVl?=
 =?iso-2022-jp?B?bE9qd0t6Mmx5VkdRWTIrVTZFNVdmeldtR0tSZ3EwbmtNNm9neUIyZ2xN?=
 =?iso-2022-jp?B?Z0NjOWtFWVJzMUFjb1NUVHowQmlrTWFzT2hrYmNwZ1Z3MDRNdmxSYjBP?=
 =?iso-2022-jp?B?RGttdDJ5Uk8wRXNUWWRMWmg2ZU00M2tBUzBIOG4yVHRyNm8vZjV0TkF6?=
 =?iso-2022-jp?B?UkIvMVF1czlYOTdtUS8xSW0zb05uVmQ2UWcvUmR0VHVaZ0VpdXZncllk?=
 =?iso-2022-jp?B?emFmOXBZREJCUXh6dm1mSnRzRUMrNlVjYzJEa3N4bFN6em4zSTV6dFVy?=
 =?iso-2022-jp?B?ZlcwT05WUXl4QXJjUis1SG51dDlqcThXRlIrOU1vUjFXb09Dek8rYmsv?=
 =?iso-2022-jp?B?N1psVUNvcjhlWjRvTm1ERnR0NXVEMmJCbWNwdlBxRnl2MnZmb3Y5V1Bh?=
 =?iso-2022-jp?B?aktRR2ZhQlRmVXdFczFIQUt3VXYwT0Rac0N4Qm42MkRsVmR4ZzhCUklm?=
 =?iso-2022-jp?B?VjJwcXRucG94QUNlLzVDMThuN1pxMWpFZkc0OURUYjhHaURRM2FHYWkr?=
 =?iso-2022-jp?B?VEUrdDBhS2NnTmsyNTljUWQ5VC9hRGdFK28rVklYaDllM05tQ1NyMlJv?=
 =?iso-2022-jp?B?V3hlLzJqTmRlWVZqdXBJb001OTZFUlMwd2YrV05TRG12K3lDcHBiR2cz?=
 =?iso-2022-jp?B?ZmFmc2d2M1NDNWFUK243UU0xVWdMdjN6cHhNakNINFVDZUdzZWNJRHFL?=
 =?iso-2022-jp?B?Vm1XMHJCdndQUWFXdVFuckNGM0pNSGZ2cVhFNGwwbHp5OXRpbE0wb2hn?=
 =?iso-2022-jp?B?U3NkN04zbjgwaUpHWkkyRHNNMWZ5WS9GNWZGWU1xZVpPZlN2T2RSUElI?=
 =?iso-2022-jp?B?TjFzYWQxSkxuYzRvd3kwVmNvT0FBRnh4WDdFZTF4Rm82UTczSUZnN0V2?=
 =?iso-2022-jp?B?L3RCRTg4MWR3OU02bFVMME9MTW4zODlvREJ2bkRMVFhpcXhXcUtFRW1N?=
 =?iso-2022-jp?B?ZUo1VVlXUElhalpPdU9GRVpYd1FXMW1tb2hFclF5QXk4d3UveFNwbTYr?=
 =?iso-2022-jp?B?d24zR2tVaWZPN1VVQ29xdzVrRzh3TCtHRkdVcHJjT3pSWko4am1mSExZ?=
 =?iso-2022-jp?B?THlyaDhnSEMzalZtZndvZC9EaVN3UWVGVDdjNGFnN21vV2tYWG10cTha?=
 =?iso-2022-jp?B?c3F6RXhBTkRKT2RhVGp4RFBFcTZvZFF6cDJreDRNSW0vWFhHRnRueElw?=
 =?iso-2022-jp?B?dmxQRlluTTQvVUptaG9UZHoxT3FqWWdEMzdid1NkQklnMjVPdE93UkFt?=
 =?iso-2022-jp?B?bUJYb0hpQVhzSU42aXpuR2RWOHZBKzdVTmI5L3M2YjZTSlp1bXczMWpl?=
 =?iso-2022-jp?B?Z0g1cGFxYXNQanRmWklaM1U0UXU4Y011cDBoeElERllKaDZKNHJvbDNE?=
 =?iso-2022-jp?B?VG83Y2FOdHFJTHVheDRhNXdvckptU3l0U3EyN2dTZ3d4YVRFcHF4QmVs?=
 =?iso-2022-jp?B?eStSbFpSOFJBM0xsay9IVDhIbVdjYjdsQjdvcGloR29yZW9qVjloUTlm?=
 =?iso-2022-jp?B?cnZqa25lVVk1bDRpMzRoZUFja3FCZmR6d1RSKzVyeFQrSjIvT25UVnlY?=
 =?iso-2022-jp?B?WUFoNS9pWlV4R0djMldnVXhMQzBjWXBiRlBmTitQVnFnWUxuTk91Y3k2?=
 =?iso-2022-jp?B?WGczREdjenpuMWhVZzJyOWI3VC9TemlkYUcya0pYZVk4NUUvK1NzNFN6?=
 =?iso-2022-jp?B?TktRbk5qRTdNUVl4eWM3alNhSEdxYXA2ZTVnUFVmdG9iQlNCbzlBbS9x?=
 =?iso-2022-jp?B?eUhyazVHbXhCZndLbEErb0R6VE5WSjgwUnZhbXJKa3lHVjk3N055aUp4?=
 =?iso-2022-jp?B?NkJmdTEyZkpOVzU1aGZ1WmVERUd3Z0s2dUJKbHdXaE5lMStFNEZJMzhL?=
 =?iso-2022-jp?B?TStCZXJKSTFvdVQ4cHpIanlJeEdySWlDcHc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8295.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9276aa65-9770-4c29-21da-08db31e5752e
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2023 12:42:58.5847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1XUtPIEXxazaNex3ncAof2rvqYAM/fAV6CGVQxT7mEZ4IV0Yz+qujHZDnfzSR9+k8tIfUnpg2sSsNavPv4s0WeWEfa/PYoKGdYZewoz/Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8428
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Mar 2023 12:43:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11137

Hello Hung-san, Kent,

Here is the basic step to build CIP Core image for RZ/G2M
using isar-cip-core:

$ ./kas-container menu
  Target board =3D> HopeRun HiHope-RZ/G2M
  Save & Build

The recent log of the build CI is here [1].

In the menu above, the following options are available for several targets,=
 but
not for G2M board at the moment because it's not in the available (supporte=
d) target list yet [2].

* SWUpdate support for root partition
* Secure boot support

As the first step, need to manually enable the IMAGE_SWUPDATE feature then =
build.
i.e.

$ ./kas-container build kas-cip.yml:kas/board/hihope-rzg2m.yml:kas/opt/ebg-=
swu.yml

Of course, the command above should fail because the required settings/adju=
stments
like these files [3][4] need to be newly implemented for G2M [5].

[1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/3970764697
[2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/v1.0-rc1/K=
config#L184
[3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/v1.0-rc1/w=
ic/bbb-efibootguard.wks.in
[4] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/v1.0-rc1/w=
ic/x86-efibootguard.wks.in
[5] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/v1.0-rc1/w=
ic/hihope-rzg2m.wks

Best regards,
Kazu



