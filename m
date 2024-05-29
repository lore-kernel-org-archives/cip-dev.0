Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B08C27C43
	for <webhook@archiver.kernel.org>; Wed, 29 May 2024 00:55:53 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.2622.1716944143904282810
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 17:55:44 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 44T0tf881923067; Wed, 29 May 2024 09:55:42 +0900
X-Iguazu-Qid: 2yAbAhOadC1axDBiRp
X-Iguazu-QSIG: v=2; s=0; t=1716944141; q=2yAbAhOadC1axDBiRp; m=CMCqoDgBjlUr44f12NWSUH6i8rUHgyLcgwq8sAeHeyg=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 44T0tes6484716
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 09:55:41 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAw9yVwTmX+H77K9cyWRGvYAZJoc1LEeA/iIiHHh3tOJWBzBAYAxgHXBhfjIjXpvq91HfDMM1vCvHMPdYDzxFIras+71Wwytg7GJesTT7bcpyZR0Knh9+GaQgG07xEBL3shYToB9Uj+g1mOYKVGpnkCHU9W2o8cgW3Yfsk0eI/zDhzTvr+GeJfOBTtmajrKNCFc8Amx35mEdKWTQViZiVHhqu+fJT3ZbM3BaCrL11BS5dvWk7zjnjHwSjuVtH4T0rUqafK3w5r8jrt1WUTvrQi3KERcLnzFB0Q9n/Pe6Ye9Y0QCqFNaVHRuRz14p+0zRcqO3xnXyZ9JuV3EdFX0gUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAmxaHgqIbtxznNIaSIGm78TrvxV7toW+1guTbM9dhE=;
 b=QW08pnQJbU56Gd/qbvZiiMpQC9zZUD64hmrp4rePghzVG1oQUAESzBotIidF8CVTMs84ZrpTFR4xdyPIHSF8Irh3aja73YeDs8SN4kazXigNNN5i2MSR2Qm5M82UE+HoMLf4skzLRPgn3bqd8OiEdI3uq8rGqS1dTHVyOabO4LWkWOlJwugu9s0GkdT9SrT2lLcxI4+LlRx8IOoKnSsQ4+IKXToPxNoVE+AdxJKzN+eAw9fwDHq6YawojgipQHgKptofNCVQNzMwJxXO3ay9ltxxL9Z81I62EG8Xyaj7TUKdKNTFHcqEDncITk6XUhzyS7G45PgoGYC13HfD4yf1cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <cip-dev@lists.cip-project.org>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries
Thread-Topic: Request for updating device dictionaries
Thread-Index: 
 AdqmtLnvothy4nUKQBSdfu8qbwxdbQD6sUBwADL8pYAAAIHQ4ABsGuiAACP4ZqAA3sUFkAAKdJigAAOXNVA=
Date: Wed, 29 May 2024 00:55:37 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB61036314A0787E645985735AC2F22@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <OS3PR01MB6103AFC364EE1AD1A9C0C81AC2EC2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103F00964E26A0F5D38A8ECC2E92@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862221FADD6EE25E032DADBB7EA2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB610353B51E2D66C802A5104DC2EA2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB1186210AA7A8F762825C4BD44B7F42@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103B95D6D38ECAB1BE70F18C2F52@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103AF590A9C795BD550C65BC2F12@OS3PR01MB6103.jpnprd01.prod.outlook.com>
 <TYWPR01MB11862B2E811EE59BBC4A0CCA0B7F12@TYWPR01MB11862.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TYWPR01MB11862B2E811EE59BBC4A0CCA0B7F12@TYWPR01MB11862.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB11938:EE_
x-ms-office365-filtering-correlation-id: 18fe691a-812c-42f1-3009-08dc7f7a0dc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?ZnplUk1CQXVQT1lTUjRtMjI1SXA5TTZSaUVaZVFxck9heVB6cEdhdUZ0?=
 =?iso-2022-jp?B?Mm9Sc1dITm1nTUZKNzVyWnZnS29TTmpqQ3dTZDVhWmRHQ2Jva2pTVlpl?=
 =?iso-2022-jp?B?NEs4WmNOU2FmbWJ2TVF1bjFZWHJYSUFpd2hCM0cxRDFmTWo2TG8venVz?=
 =?iso-2022-jp?B?djJ2WitmZ05pZTIvZ0VhRjZtQzNRUnhLaTFFTFFOS2ExS2hlTVBkZU9Z?=
 =?iso-2022-jp?B?UEdGTHBKaEk5TVJNSzN5ZmxxM0NGcDFiTksxNlAwMncwR25yUHhEVnZL?=
 =?iso-2022-jp?B?TTUzTzdPZjhDdjkwanN6c3VmMkNCTmZvdm1vbTZ1dE80SktEUE9QK0Rw?=
 =?iso-2022-jp?B?bmFRNnhMNzhUMGdUZWdmNzl2WXBQWlNDUXduWGdvTFN0MGJtV01VRkdY?=
 =?iso-2022-jp?B?bmhGWmhIL3BJTGFURVpxQWZObkJzQzhxSWxERGZEZEs1K0VOTEQyM2xo?=
 =?iso-2022-jp?B?SUU2d1l3QVFuSEVMbmk0eDJoTzYrYzdMOStXc0pTUE9nVU0rOXcrSGZY?=
 =?iso-2022-jp?B?SjNVYWxROEV0c29OcUx0b21CaERzZmczZDNQSzZNVzJlcFhYSUVKKzhH?=
 =?iso-2022-jp?B?blp3L0I0ZjJack5MM3FubEtReFNuZEFnUm1Yam9PcFRQK2NUMkY4N1F4?=
 =?iso-2022-jp?B?cElvMEEwQjhIVnIzeUcyc2pPeHFveGh4M1FRQk5vTCtuT1lHMWdYWS9m?=
 =?iso-2022-jp?B?ZllzT3pxN05aY2ZkZUtMMzJaSkdSOFRvM3hyRi84TCtzSWI4OTVCdzZq?=
 =?iso-2022-jp?B?V3d1SytucjlHMzZ3YU16UnZCQlkrSVBYN0hOT1FXNG5PVDRvTEc0MU81?=
 =?iso-2022-jp?B?clhhMG5raTlWNUI1bTRYOUxTaGh5aDQyckZKaDFxcitCL3pnMmxOaG1U?=
 =?iso-2022-jp?B?SjJ1NEpoSjRzUllyTmdKRU02NnBDY3lZSHY1aGptVklUNnNnOWUyMUox?=
 =?iso-2022-jp?B?eFlWMVRIVEFnTnNDY3YzTk82THN6ZkZ1cXg5V1JISk10RUIyUTJQaG1K?=
 =?iso-2022-jp?B?WW92TG0wbHRPQldGNjNvT3A2N3BnOHk3ZTVzRE5zckpQdVRSamdIWVdX?=
 =?iso-2022-jp?B?VnFBL3hLM1ZlSU5saG00TkJoT2I2bWtyNjdpWTQ3VE1hMEM5OU95M3V0?=
 =?iso-2022-jp?B?MkJIckhTOEpVb1BjQlpCM1QrR1czSnAxZllIQ01MaEtLVmx6SFd6T2ND?=
 =?iso-2022-jp?B?cjJDbVI3dHlHNWJHK1NoMGl5bEQ0b29oV21jMjg1WHJheTZVRWZzdlhT?=
 =?iso-2022-jp?B?d1ZkYTVOYnRwRU4yVERwbXFWa0lxZzFkeG5TbUdNeUJIbDJXcFp3V2dl?=
 =?iso-2022-jp?B?OWNISytoNWxSMWdCeVd0RzdQbE1hMnIxRVFZNkIrRzRUTUI4bmlpSW5Z?=
 =?iso-2022-jp?B?TDBRQ0NKUDdmbGRpTXd5RlNjSWxRdjVzMkZ3R3p0SEFyRzBHNXZ0M2tJ?=
 =?iso-2022-jp?B?UnMzeVh1Mi9udHJKUFhYTkIzRXI2SkY3c3ZQUnpINDIybW5NUFNmK3Ay?=
 =?iso-2022-jp?B?Y3dFbU8xWEk1NnZHRXM4eWM0dlMvUnVqMC9QdnpGYjJGVExTRmEyaVJi?=
 =?iso-2022-jp?B?a2NVWXhxVCt4azIxUk9VRTZJbmZRbGY3akZ0NHE0Vm8rWW1tMHhkRzgw?=
 =?iso-2022-jp?B?alJKb0hBZXh1dS9xL0lXaVNVbXpDalYrYTZNcjY2K0dlR29PLzBjNnRH?=
 =?iso-2022-jp?B?S2tBWUw0a3dteFI1ZjV4Nm5QamRaSnM0SC9zVmNocDAzbFBsS2pLTDdL?=
 =?iso-2022-jp?B?STBtTXFmZ3ZhN1JuZGVQeHJ3RjluU0R2a1VHVDhYZWN6L25sSmhES2Vv?=
 =?iso-2022-jp?B?cCtPOE1mS3YxOU5xU3dzTXA0VHVaSTRYaDdMVjc3QVhUcmxNS1lVUVZW?=
 =?iso-2022-jp?B?TmY0ZVgvR1JySjRRcWlRWU9qN3hvPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TWFVM2ZzU3F3WlQ3M1UwN3JSOGprVEw0YVZCTERvbWVxOVRqa29ldWtQ?=
 =?iso-2022-jp?B?eWs2N3JqSGxtejdyRHo1SDN4aU92YUJUN00vM3dhQmVGZ1BCbmI0S2hR?=
 =?iso-2022-jp?B?Y2lxNU12YzJMWW90eEtyci9yL214R3RoSDFCMUFkTFFmdXRlOFhtYWRE?=
 =?iso-2022-jp?B?Wng1NXlyY3Q4YjFpUllHZUt3WVo1Qy8zOEYwZDhpVC9qTVB6QXdOMmgr?=
 =?iso-2022-jp?B?ZzJWRUpQL0Q4UGlERUZmQ3NIV0k3ZFd4UUlndFZjZTVtMVJTbG9tTGkr?=
 =?iso-2022-jp?B?ckVONkNYcjVGY3B0Y2s3OUxSZ2RmeHFDd0p5QVpvUXQ2Yml4aHBpYVU0?=
 =?iso-2022-jp?B?TkxvU1kvcHFyT0hsVHExckluOWlhVjY0Z29vL0U1NWFaUklIN2xDa0JJ?=
 =?iso-2022-jp?B?R0ZIRXp0bXZ2ZS9xWUVndWFHVnVDcjUxQ0JSejhIdyt5OGpvU3BlMWVq?=
 =?iso-2022-jp?B?azFRVzRSQTRtZUtkdjE0emlnR3BoaUVHbk5uSk1BY1pFY2pUV2l6YXY5?=
 =?iso-2022-jp?B?OGs1MWhNYVI5cVB4NVBKOEF1OXYwd2JCb0JNSm9DNllnWDRtbzZTOEcy?=
 =?iso-2022-jp?B?WDljT3ZHN2pla1hhNVZRL2ZGZ1ZRSThsN3dJTjlyK2h6NFpySHVUUXZz?=
 =?iso-2022-jp?B?Y1dmdnZITTUvcnFnZ3laYS9zekZZSW9DNHhQK2FFRTBhQmNsanluRlpT?=
 =?iso-2022-jp?B?OU8xSGwzdDVJR0ZWakpRYThTcE85aU1qcU5sWFMwbzNGeHN1WFlkTjBX?=
 =?iso-2022-jp?B?c2MxV2Eya2V2S1RtNTdIc2NqK2lKU3Y3akxwa1dWWGM4Y2pJL2d6aHAv?=
 =?iso-2022-jp?B?bFhwQS93b0FQWFJKRExMay9wTXU5VEVXR2FhTUZVL2lqQnkzczZHTWk2?=
 =?iso-2022-jp?B?OGZSaUloYzZCSU9vRG1VSitYam14UmZITlA1T2JaUllYVkpURDR3K01L?=
 =?iso-2022-jp?B?ZmJ1bk1UdnVVR2FtNGdMdWZaRHU1ZG12SHc4OGFRbktub0NUMkdNLzFP?=
 =?iso-2022-jp?B?YUZzbGZoMDJZRlM3dG9FbFlJdzY5L1VqUDd5eGpFdkxlOFE2d0t4Z201?=
 =?iso-2022-jp?B?cXNVZy84Wll0STVOeGIwU3N5dzZGQ0g0cTYyNTJ4a0JSN0JlenBjTS9p?=
 =?iso-2022-jp?B?MVhMTWJjb0xscnN6TGlzQlM5ZXk1UXdKWWd1WVdSblFWeTlRVkhpSjBF?=
 =?iso-2022-jp?B?dGNFMVZHNUwwVU9DVjd6dG1KdjNFOTk2WE91ZHRpcjNCQ2VwTU1tR1By?=
 =?iso-2022-jp?B?dUh1QzB3NEQyQWpTY0tlTmc2RnUrbThUSzB4aC83aGhtRjhtSHEzYVRm?=
 =?iso-2022-jp?B?dE9oSTlSNzZGWWFyOUFmRzRIWWI4TzlHVEFGdHgrMDRyaUVjS3FoSG4y?=
 =?iso-2022-jp?B?UkJIU1NHYmhjNk1TUENkekoxVThyZFh2ak1tT0xtVmJpclJmR25JY0Nn?=
 =?iso-2022-jp?B?c0dGT3pZQ082YlRyeTVhWlBiRVY1alYrOHBzaEVNUFhpTkpLY3d4NTNy?=
 =?iso-2022-jp?B?TlI5bzBMR3Vha2liOXY1UlJxVCsxLzBTKzFpbDVBYnNIaHZqRzhBU0Z5?=
 =?iso-2022-jp?B?WnBQbXZlU3N0V0xEeWV2SE1iT2ptMExhNE9naTVCaHZQTHg5YUZISzdX?=
 =?iso-2022-jp?B?MjNVNUFQVWVTYTRtb0t6VVkvMEpSZE1ldERONzdYSFk5dnRjQVAxa25z?=
 =?iso-2022-jp?B?anE0Q0Yxeko3R05NMUZSbjZFZ2pKM3VlZnB1OG9CR3ozekJSb01PV1Ux?=
 =?iso-2022-jp?B?VFA5MS9jZEt2bUFwczg1cWxOY0w3RENzc3pTNmlZZWVFVlpFQ0FGQlpE?=
 =?iso-2022-jp?B?U0lUUFhNYzZLZjUzOFVYaUJHMmJoR3VOSnd0MDFONHhhQzBjUzkrOHA2?=
 =?iso-2022-jp?B?VllzMWs4VG43SkVEOU1nSmtYcSt5NGwvTUZYRWUxRlNMZU1ZMW01RGd0?=
 =?iso-2022-jp?B?TG54bjN2QmwxY0FudFAxRjA5SEcxT2JOSExsNkphcXVFdkNPS3ZIYXdk?=
 =?iso-2022-jp?B?Y0FXanhVMTFxMHhEUUpiMy9YMy9HWnkwMHNOenJvd2VBQWlsbmUzRlpj?=
 =?iso-2022-jp?B?OXBibFk1WjJTbmhOYy80Z2IyZEVWblk4V2p1YjRXbk9sTWxNSUkwc1I5?=
 =?iso-2022-jp?B?UVNXcDJramthTnIydmVSUVBqYlMxMlhLQzZsVzhDY2NwMTM1MEViRXJ3?=
 =?iso-2022-jp?B?clhsL3QyUDlOQmRTR0QxRXN5RjhnZnJ3ZjZKMjc4VVJMUnpYY2F4aGtB?=
 =?iso-2022-jp?B?ZHJCcHBGTTF4WUtyZTRvMmdjMGxJeVpmZ2RPbUsxc3VvckpOc3NaYThR?=
 =?iso-2022-jp?B?eFdiWTlnNzExcklQN3BST3BrVlZvK0E1NWtGQWlwQS8yRytRbjdkS29w?=
 =?iso-2022-jp?B?SDJKOVc1MUxGODZXWlIvUTRhcnAyRHI2MkFGSlpOV2QyWDVDdUVMODI1?=
 =?iso-2022-jp?B?eDl5NmtnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18fe691a-812c-42f1-3009-08dc7f7a0dc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 00:55:37.3183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HpC9EmahIQmDxBhClrWOew092M52KN8aJdQG+fovpeKwm65ckIhLG0EF+I1MCcpV/ITfQke3H8NkeS5HDYbY5UKZsCyTdJyMCgLYUg+2d/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11938
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 29 May 2024 00:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15976

Hi Chris,

Thanks a lot for your support. I apologize for not including changes to ins=
tall swtpm and ovmf packages to the slaves. Thank you for creating an MR fo=
r that.

I agree that we must work on this limitation that only one QEMU device will=
 be able to run these jobs in each lab. The problem is if the image boots o=
n a QEMU device in a lab, it acquires the below socket.

swtpm socket -d --tpmstate dir=3D/home/######/XXXXXX/isar-cip-core/build/tm=
p/deploy/images/qemu-amd64/cip-core-image-security-cip-core-bookworm-qemu-a=
md64.swtpm --ctrl type=3Dunixio,path=3D/tmp/qemu-swtpm.sock --tpm2.=20

Then if the other QEMU device in that slave also starts booting, we will ha=
ve some conflicts to due to which there are high chances that both the jobs=
 can fail. Let me investigate on how to overcome this limitation and make t=
he both the QEMU devices ready to run these swtpm related jobs.

Thanks and regards,
Sai Ashrith Sathujoda (T S I P)



-----Original Message-----
From: Chris Paterson <Chris.Paterson2@renesas.com>=20
Sent: Wednesday, May 29, 2024 4:43 AM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>
Cc: cip-dev@lists.cip-project.org; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=
=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayas=
hi@toshiba.co.jp>
Subject: RE: Request for updating device dictionaries

Hello Sai,

> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Tuesday, May 28, 2024 7:23 PM
>=20
> Hi Chris,
>=20
>=20
>=20
> Today while I was testing isar-cip-core LAVA job trigger pipeline, I=20
> noticed that the one and only device (qemu-renesas-01) which has=20
> custom device dictionary changes to use swtpm related scripts to boot=20
> CIP security image are gone. LAVA | Scheduler | Devices |=20
> qemu-renesas-01 | dictionary (ciplatform.org)=20
> <https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/devicedi
> ct> . Because of this none of the QEMU devices present will be able to=20
> test Swupdate, secure boot and IEC layer.
>=20
>=20
>=20
> Chris, I am about to send patches to isar-cip-core to trigger LAVA jobs.
> For every pipeline it must run 11 jobs on CIP LAVA QEMU devices. So, I=20
> request you to please update device dictionaries of only one QEMU=20
> device in each lab so that we can have 3 to 4 QEMU devices able to run=20
> CIP Core jobs and this also makes test stage runs faster in=20
> isar-cip-core pipelines.
>=20
>=20
>=20
> I have already created an MR https://gitlab.com/cip-project/cip-
> testing/lava-docker/-/merge_requests/35 <https://gitlab.com/cip-=20
> project/cip-testing/lava-docker/-/merge_requests/35>  to include=20
> required scripts in all CIP LAVA workers. I mentioned the reason why=20
> we need to manually update the dictionaries instead of updating the=20
> dictionaries of all the available QEMU devices here=20
> https://gitlab.com/cip-project/cip-
> testing/lava-docker/-/merge_requests/35#note_1921132805
> <https://gitlab.com/cip-project/cip-testing/lava-docker/-
> /merge_requests/35#note_1921132805>  . Please have a look at this.

I'm still not happy with the approach this MR is taking, but as you need th=
is functionality working, I've merged it for now.
I've created a follow up issue and assigned it to you to look at when you h=
ave time.

I've also created an additional MR to add the functionality missing from yo=
ur own (we need to add packages to the LAVA slave Dockerfile).
This too has been merged.

>=20
>=20
>=20
> I request you to consider this as high priority because we are working=20
> to enable this LAVA job triggers from isar-cip-core as soon as=20
> possible. We will not be able to test if none of the QEMU devices are=20
> able to run any of the CIP Core jobs.

Lab-cip-renesas and lab-patersonc have both been updated to the latest cip-=
lava-docker version.
One qemu machine from each lab should now work okay for your testing, but p=
lease double check for me.

I will ask the other lab maintainers to make similar changes their end.
Once done there will be four qemu devices available to you.

Kind regards, Chris

>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Friday, May 24, 2024 1:15 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com>
> Cc: cip-dev@lists.cip-project.org
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
>=20
>=20
> Hi Chris,
>=20
>=20
>=20
> I updated the corresponding MR lava-slave/scripts: Add scripts needed=20
> to run for booting CIP QEMU security target (!35) =1B$B!&=1B(B Merge requ=
ests =1B$B!&=1B(B=20
> cip- project / cip-testing / lava-docker =1B$B!&=1B(B GitLab=20
> <https://gitlab.com/cip-
> project/cip-testing/lava-docker/-
> /merge_requests/35?commit_id=3D6642a2390ead758ecbb8b096c62c4c5d4fd504b3>
>=20
>=20
>=20
> This MR only adds the scripts in the workers. Updating device=20
> dictionaries on only one QEMU device in each worker has to be done manual=
ly.
>=20
>=20
>=20
> If you have further review comments, please provide them in the MR.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Sent: Thursday, May 23, 2024 8:04 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)=20
> <dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com>=20
> >; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> >; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Sai,
>=20
>=20
>=20
> I can update the device dictionaries, however each lab would need to=20
> update it=1B$B!G=1B(Bs worker docker image to include the swtpm*.sh scrip=
ts.
>=20
> Before we do this, we should really finish and merge the corresponding MR=
:
> https://gitlab.com/cip-project/cip-testing/lava-docker/-
> /merge_requests/35/ <https://gitlab.com/cip-project/cip-testing/lava-
> docker/-/merge_requests/35/>
>=20
> Please could you check the remaining threads?
>=20
> Once merged I=1B$B!G=1B(Bll ask for each of the workers to be upgraded (I=
 only=20
> have access to my own worker).
>=20
>=20
>=20
> I=1B$B!G=1B(Bll remove the swtpm-jobs tags I added the other day, so at l=
east=20
> your pipelines don=1B$B!G=1B(Bt fail ? they=1B$B!G=1B(Bll just run slower=
.
>=20
>=20
>=20
> Thanks, Chris
>=20
>=20
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-=20
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> Sent: Tuesday, May 21, 2024 12:05 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> ;=20
> kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> ; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hi Chris,
>=20
>=20
>=20
> Thank you so much for adding the tags to one qemu for each worker. But=20
> the device dictionaries for these tagged devices need to be updated=20
> with the below snippet. Without these changes we cannot boot the=20
> security image in LAVA.
>=20
>=20
>=20
> {% set user_commands =3D {'start_tpm': {'do':'"/usr/bin/sh=20
> /usr/local/bin/swtpm_start.sh"',
>=20
>=20
>=20
>                                       'undo':'"/usr/bin/sh=20
> /usr/local/bin/swtpm_finish.sh"' },
>=20
>=20
>=20
>                         'manual_kill': {'do':'"/usr/bin/pkill -15=20
> swtpm"'}} %}
>=20
>=20
>=20
> Just like it is updated for this device LAVA | Scheduler | Devices |=20
> qemu-
> renesas-01 | dictionary (ciplatform.org)=20
> <https://lava.ciplatform.org/scheduler/device/qemu-renesas-01/devicedi
> ct>
> .
>=20
>=20
>=20
> Can you kindly update the device dictionaries for the below =1B$B!H=1B(Bs=
wtpm-jobs=1B$B!I=1B(B
> tagged devices ?
>=20
>=20
>=20
> *	https://lava.ciplatform.org/scheduler/device/qemu-03
> *	https://lava.ciplatform.org/scheduler/device/qemu-cip-siemens-muc
> *	https://lava.ciplatform.org/scheduler/device/qemu-patersonc-01
>=20
>=20
>=20
> I will contact the maintainers of isar-cip-core project regarding=20
> CI/CD variables.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
>=20
>=20
>=20
>=20
> From: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Sent: Tuesday, May 21, 2024 4:24 PM
> To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba-tsip.com> >
> Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting)=20
> <dinesh.kumar@toshiba-tsip.com <mailto:dinesh.kumar@toshiba-tsip.com>=20
> >; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> >; jan.kiszka@siemens.com=20
> <mailto:jan.kiszka@siemens.com>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Sai,
>=20
>=20
>=20
> You need to talk to the maintainers of the isar-cip-core project to=20
> get CI/CD variables set there. It=1B$B!G=1B(Bs not my project so I should=
n=1B$B!G=1B(Bt make=20
> such changes.
>=20
>=20
>=20
> I=1B$B!G=1B(Bve added the swtpm-jobs tag to one qemu from each worker. Ch=
eck the=20
> =1B$B!H=1B(Bgreen eye=1B$B!I=1B(B on the right of this page:
> https://lava.ciplatform.org/scheduler/device_type/qemu
> <https://lava.ciplatform.org/scheduler/device_type/qemu>
>=20
>=20
>=20
> Kind regards, Chris
>=20
>=20
>=20
> From: Sai.Sathujoda@toshiba-tsip.com <mailto:Sai.Sathujoda@toshiba-=20
> tsip.com>  <Sai.Sathujoda@toshiba-tsip.com=20
> <mailto:Sai.Sathujoda@toshiba- tsip.com> >
> Sent: Monday, May 20, 2024 11:23 AM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org=20
> <mailto:cip-dev@lists.cip-project.org> ; dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> ;=20
> kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp>
> Subject: RE: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Chris,
>=20
>=20
>=20
> Any updates on 2nd and 3rd requests I made in the below mail ?
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)
>=20
>=20
>=20
> From: ashrith sai(=1B$B#T#S#I#P=1B(B)
> Sent: Wednesday, May 15, 2024 4:41 PM
> To: Chris Paterson <Chris.Paterson2@renesas.com=20
> <mailto:Chris.Paterson2@renesas.com> >
> Cc: cip-dev@lists.cip-project.org=20
> <mailto:cip-dev@lists.cip-project.org> ; dinesh kumar(=1B$B#T#S#I#P=1B(B =
TMIEC ODG=20
> Porting) <dinesh.kumar@toshiba-tsip.com=20
> <mailto:dinesh.kumar@toshiba-tsip.com> >; hayashi kazuhiro(=1B$BNS=1B(B =
=1B$BOB9(=1B(B =1B$B#D#M#E=1B(B
> =1B$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp=20
> <mailto:kazuhiro3.hayashi@toshiba.co.jp> >
> Subject: Request for updating device dictionaries
>=20
>=20
>=20
> Hello Chris,
>=20
>=20
>=20
> Hope you are doing well.
>=20
>=20
>=20
> Sorry to disturb you with these extra things I need on CIP LAVA Lab.=20
> Let me consolidate my requests in this mail.
>=20
>=20
>=20
> I am preparing a patch to trigger LAVA job definitions from isar-cip-core=
.
> Currently I am working on that in a custom branch. Before sending that=20
> patch, I have created an MR to update the cip-core-ci repository which=20
> is required to run the test jobs in isar-cip-core. I will assign it=20
> for your review soon.
>=20
>=20
>=20
> I will be able to send the patch to add test jobs in isar-cip-core=20
> once the below mentioned things are done.
>=20
> 1.	This MR needs to merge build-bookworm.Dockerfile: Include lava.sh
> and templates in the docker image. (!3) =1B$B!&=1B(B Merge requests =1B$B=
!&=1B(B=20
> cip-playground / cip-core-ci =1B$B!&=1B(B GitLab=20
> <https://gitlab.com/cip-playground/cip-core-ci/-
> /merge_requests/3>  which I shall assign to you soon after some=20
> internal review.
> 2.	I need some variables in isar-cip-core CI/CD setting section like
> LAVA_USER, LAVA_TOKEN and SQUAD_TOKEN. We don=1B$B!G=1B(Bt have the privi=
lege to=20
> do that. I will mail them to you personally. Please hide them in=20
> isar-cip- core Gitlab CI/CD section so that I can use them while=20
> running lava.sh script.
> 3.	Since we need to run these LAVA jobs when pipelines are triggered in
> isar-cip-core, I am making changes in such a way that pipeline keeps=20
> running until all the jobs are done and we report the health as a result.
> It will take around 120 mins to run all the jobs. We have only device
> (qemu-renesa-01) under lab-cip-renesas. So, I request you to please=20
> add the swtpm device dictionary changes and swtpm-jobs tag to only one=20
> QEMU device in every LAVA lab you can access. By this will be able to=20
> reduce the pipeline run-time due to simultaneous runs.
>=20
>=20
>=20
> It will be very helpful if you provide your support with the above-=20
> mentioned items.
>=20
>=20
>=20
> Thanks and regards,
>=20
> Sai Ashrith Sathujoda (T S I P)



