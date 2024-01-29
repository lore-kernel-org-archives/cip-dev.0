Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD640C47422
	for <webhook@archiver.kernel.org>; Mon, 29 Jan 2024 05:29:04 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.8190.1706506141248389444
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Jan 2024 21:29:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.152, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 40T5SxAA3507828; Mon, 29 Jan 2024 14:28:59 +0900
X-Iguazu-Qid: 2yAbno87TPPwOs1EtU
X-Iguazu-QSIG: v=2; s=0; t=1706506139; q=2yAbno87TPPwOs1EtU; m=GFp9oKUAtUbVRKCCuoT8IwArzgstroql4gqeoXshggc=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1800) id 40T5Swat2568043
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Jan 2024 14:28:58 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ecbz4dm1h8ckybS788c8tAnsflp/mqg7+s0DzUobw8QuL6qFkTIMSCNdSPT+w1gRgv/zQVpiJIM4baM7APgdlMz6sbFU+qgmzmeOv1nw4mpDg2y1EEjVxT0i4DwOVAuW8qzSHTYsbSQ7VKtjEKESbcuhuY69sKLpO7iPsk2GsKGL19W2ePUOU0hGkmZ92cz6LCMWSNYPtXxitjT1DckBooAvbNXMMN90Oymuu5JX5/w2roJQW0Us05BEoq7+XEGP/zZuTzAZjRTf3YktDDb8S0IiVCyXac1HjQd5fN69ZKZ/QBaJrlNG4nU+TmXbncFtP3YRAMtv4NwmixN4vGWIFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nh7sf8sIZcGIuV0hBNMl/qX/xUfw05Ue/IBlDe8lQtE=;
 b=fdmKAjX0WQBsIEYf0w+KR7v/uzOh69aRk/VRiL8DY4KSC1UDCzpkLaJ/UAl8tMecRGuYhZ9m1SIVgCIrISVnh5z/UdJOed3rKv3FK2oePFpx14r/C1biNRNFJo5F3ZyZLANnF4U53yjYHcPLN8Wl2/Hp/VHD5SXNtXbXuOMtD4x+LGlaPnElx4FoKFRMQ9wWuS1nDzj/NWC0lVUaJba+ff70FR+MqLmlEpMxs2seWMdLQK+HDizmKGVjE91ds9AGBuE+maMopzss7pPiujOHWjXypFljVkSnvd1Chb/5t6DsYAHqY1CAZFWA9lMG5vM+yZRNAxCxRaQ7ChO/i9koKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <Chris.Paterson2@renesas.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata1.pyla@toshibaap.onmicrosoft.com>,
        <Shivanand.Kunijadar@toshiba-tsip.com>,
        <Adithya.Balakumar@toshiba-tsip.com>,
        <Zaiba.Sanglikar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting the
 image )
Thread-Topic: Query - ( Running Linux commands in LAVA host before booting the
 image )
Thread-Index: 
 AdozwvV9UNGTGxZYRGqGmeIZ2P0TlwJpyH3gAACV+xAAAiUg0AAAckCwACcWkkAAPCHDMAJbyUuwADZLu0AAEFBIYAAqverQAOAY0AAAeDM7MAC1qp8QAADiP3A=
Date: Mon, 29 Jan 2024 05:28:54 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: 
 <TY2PR01MB4954D32835FCAF8245111E1DC295A@TY2PR01MB4954.jpnprd01.prod.outlook.com>
 <TYYPR01MB6809B0815132278008135537B761A@TYYPR01MB6809.jpnprd01.prod.outlook.com>
 <TY1PR01MB1070792932CC39BCD6E37FF35C261A@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <OSZPR01MB681639B047029A2C720FAD7DB761A@OSZPR01MB6816.jpnprd01.prod.outlook.com>
 <TY1PR01MB10707DEC66CF726FEFF7DAFCDC261A@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <TY1PR01MB1070792A35933C13BFD32AE03C260A@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <OSZPR01MB68167508831B6B3A55888AF5B7672@OSZPR01MB6816.jpnprd01.prod.outlook.com>
 <TY1PR01MB107074A82AF2F4E9A73333684C2732@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <OSZPR01MB68162D9212C6616390DF1FE6B7722@OSZPR01MB6816.jpnprd01.prod.outlook.com>
 <TY1PR01MB10707BA6D20AF995CC74ED3F2C2722@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <TY1PR01MB10707149C393DDC7056AE6EE0C2712@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <TY1PR01MB10707EF759D0ED715812A9565C2742@TY1PR01MB10707.jpnprd01.prod.outlook.com>
 <TY2PR01MB320921DA55982D635943FA8FB77A2@TY2PR01MB3209.jpnprd01.prod.outlook.com>
 <OS3PR01MB6103EA4145114BA537F0CFDBC27E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS3PR01MB6103EA4145114BA537F0CFDBC27E2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYYPR01MB8247:EE_
x-ms-office365-filtering-correlation-id: fb4c8c62-bb47-435d-1ea5-08dc208b2f19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 tZVR05wIvGMEz0K3FwCEBpBmXvfNNYeZDfeDJ3vlyqECV2ybKssSkbPfaq54tsw3DGDQqUvqJlOc+QFPG0ledvAh/NRG/63OW8HBzybN+pwRXQQ6vYK0Qb4XvoyjNFjJha4cE5WWDnBAaP1uRrSr6nMzcqpRZnIW76ct20JIM9pGtKTSNxihxbc+sk1gxy1LnSnlcHyl5uinKia1Z8FhDxltjECA2ubFuL6J7HISJnapu7LDALKLOMAPSaMWEcOE/ffOT7U+X2jTco6lsZUNWlwOnm1uhNwXn/fcbuMuGgozQX+qmmeBbtDe/uaoEt40JlGW4d2m7Yi1D9ESBKslfgqJ7BoI+ciOldCkny5h6AhavfdVIOsVq5rJwfGDK7rg6Wa2KufaO8hfgenqAD1/mLN27s9A4xbSRlVoWYvinMSCNUG0mc249rsqyg7a0GTqRzYo6ZDPWM+Db4d5WUfynEZ9C903yLUCQ8F+JqnUj80sR/UHPA25pxkX/++5wHDh0Hlc7J6LcVItFe8mkCm/wACYWAZy1G1V11mCvu4kKuy46B8rkLhaGaM7DaXnN9JtRiCnEt3V5KwnCIWhQQ1pWHhFtp8IbXPqEMoR7ePDm8M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(966005)(478600001)(55016003)(99936003)(86362001)(7696005)(122000001)(166002)(38100700002)(83380400001)(6506007)(9686003)(2940100002)(66899024)(53546011)(6916009)(52536014)(4326008)(9326002)(2906002)(316002)(5660300002)(8936002)(30864003)(8676002)(33656002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(71200400001)(54906003)(85182001)(38070700009)(26005)(107886003)(41300700001)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Tjg1alY2TDYyWm03U2NZN3JXUHBnejhmWHZSTG0wcWF4RXUwZ2VrNmZU?=
 =?iso-2022-jp?B?c0NUVkNVWTVGdzhtR1RQY01TSHFjUnByY29ScDNnSFA2Rk9JcEErODdC?=
 =?iso-2022-jp?B?U3JOa25PMi83b3M2RzN6K3dCelZvUXB3OG92bFVhYVE2K2VubmxMb09n?=
 =?iso-2022-jp?B?VFpabnNkRyt4K1NleW5mbHQzL0hsVDJ3VHRKaE9ZZXNUYjlNYlY3UnFJ?=
 =?iso-2022-jp?B?S1U5STBzWCtKZ2IyL2FQaFRIL0ZDbnNnYmRleXN5d2trNUJoVVZKbGFS?=
 =?iso-2022-jp?B?aTZhQks4VGFQWjFxY1Y0Y3VOYkJaRmpDOGZuQUVTWkdPb2t6M0ZSL1Ew?=
 =?iso-2022-jp?B?MEJzNHhFc0dsZWp3ZVVQdDhJQm0vU1JxZWd4RGFHZkxIcU5GeGQxYVI4?=
 =?iso-2022-jp?B?dG01TFJJbTdudlhoSG1jOTczMndjN29MbFJhczdqQityNEV6eDIvWTlW?=
 =?iso-2022-jp?B?L0Y5aFk5L3lCRjE0M0t0cE5vaHNBVTJYc0lRN1VDMmZwWGIyQnlWWTZm?=
 =?iso-2022-jp?B?VHgzdzk2ZjZnVGpyZUIySzdOdWpzSm9WNzg0UVVwS3RteG55VTR5TUlC?=
 =?iso-2022-jp?B?NG5QYmNwb3EvMCsrMW5XVCsyb0NQWHprc0d4QlhLa21YUzNuS1BpY2Q1?=
 =?iso-2022-jp?B?TU13OGQwMTNtcTN3VEJvREozaUlBaytMcFFSay9WR1ZLUzZuTUl0dWZQ?=
 =?iso-2022-jp?B?MXF5ZVBxbTNKdnRFaitzNGo2NXNUdFBTb0VNeXVMTGg1eXI0QnFkZG80?=
 =?iso-2022-jp?B?aGxKckJtMVVScUMzWTZMUSt6aXBnYWgrY0Jsb2NJRHJQaWNrRE4rUlhI?=
 =?iso-2022-jp?B?ZnRFQmM1Q09RWlJlWC9UZHV1TEVWVjcxbDFCd1pYYU1tck93NDZFeFNC?=
 =?iso-2022-jp?B?VW44UVU4YzFlanNWNkNBMHZzQTU0R2JUVmxES3F4QnVsa2t0VkxaRXZZ?=
 =?iso-2022-jp?B?UnlyUmdNRUVDUWRvS1NLZFdFM0FPaTgxWVJzTW53bW53NWtDa0Y5QjUx?=
 =?iso-2022-jp?B?VHNaMktwSGdTSE9ZUHVNYnZJSXNxb0xKRjR0amJwZVZlSHpPdURlaTVz?=
 =?iso-2022-jp?B?ZzdtZmFHRTRudkNkc2Nya3pHYVgwRnhUVXg1UHJFQ1NoMzZVTCtVWTV4?=
 =?iso-2022-jp?B?UEFyYnYybTZIVWNnOVU5TktjbHRoR0ZYN1MvSFlEVVJQVjdEdVQ2TG0v?=
 =?iso-2022-jp?B?ci82NDMxaVJKUEorcklYQWJFMkI2c25FYll4eCtDb3pCdFhOS1p3ci9D?=
 =?iso-2022-jp?B?Y0o3aDFWSFhMR1VjRFo1R085VTdXalBqb1h3VVcrRTY3TElyVEw0dVRI?=
 =?iso-2022-jp?B?V1hyTzZ1ZmdvdHdFUEh6WGVlN1gwU0ltSC9TalZEOWx4Unl2UHZmalJP?=
 =?iso-2022-jp?B?V3hLU1d0dHdhWUJIYVAzTjBGYzBjb0h5SnFMMmdvdHJPWWNVVUZNc3l5?=
 =?iso-2022-jp?B?aFh2dE1aUlp4RmZyNytZMGtuYTd3eDQ0d1g3VStLWE03VTY3WFQvNmRC?=
 =?iso-2022-jp?B?ejRRZkNHN1JyQUZHbFNId2FrUDhpd1p3dFovZ0Vuc1JBVXJ6dHFLQmxQ?=
 =?iso-2022-jp?B?RUFsNWhLUzRoa3ppOEkrYldDVWgwZFE0TDY0QUJoZ3RRYzNPdUNtQ05M?=
 =?iso-2022-jp?B?ODVaR3ZsWWM4Q3h1S2NPMUhTTmJTUGk3UXplMXBhVmVoWTdoK3psNW1x?=
 =?iso-2022-jp?B?cUpMc1A0NW5zWEJIby9kbzNUZzdKbUFVWHB0bWRXYnlNUDBGdG9BQlhv?=
 =?iso-2022-jp?B?NGIxNC9zcWd5cUhWOElldHBTdFVoTFhhZnhGclliOXpGWVVDWWtyanlz?=
 =?iso-2022-jp?B?Nkt6UjJIT2F4RjVUdlY0aThlMFJmaVdVREVLUWNoQTBkS0tFa3dUbklH?=
 =?iso-2022-jp?B?Ynh2dG8zZVh1TmphSTJBZXA4eWpJZUlyYThFelFBZVg2S0dVQmg4ZjVM?=
 =?iso-2022-jp?B?d3o4VWhXcFg3ZWZyQUt3bjFWVE1rT3JwREJHVGZVVHh3Q1ljUnNJZWVs?=
 =?iso-2022-jp?B?K09oZHVkSThER0l0QVpjenk5RXJxdFhaZ2NKZmpkZ3YzRkdNVHhCMDk3?=
 =?iso-2022-jp?B?aURROVB5bzZYbjJ0MFRMWVZidm9zMFd3eUNnWWt4VElrd3JhVnRGd3ZQ?=
 =?iso-2022-jp?B?R05IWkZoY240NU9VZFZDZTVFKzlZL0FlQ0Vmb3BQWU5Fdnp4SGg3ek9W?=
 =?iso-2022-jp?B?Z3VzczR5TVpSeXY0U2ZtTmIzZjNncEwyWndIbWRIaHI2ZUpwSG5QYlZw?=
 =?iso-2022-jp?B?VnVrVGE3bkQ1VkY1Zk5sdTdBSEpPbG9sWFI3cjRLUTZ5M2IvRWRHVno0?=
 =?iso-2022-jp?B?alhqd3M2RjYydnNOTG5zcU9aT3NxMHNId3c9PQ==?=
Content-Type: multipart/mixed;
	boundary="_004_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4c8c62-bb47-435d-1ea5-08dc208b2f19
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 05:28:54.2381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Smn33ITACO5y6/AxfzQwcnS8PceNvZVWjTR7agtQfOcvWoxqfFG16xX/ArBGPymPeJKkyF6ep9YfUsudnse2OFWNR3JVy9ABhb8BojZfA9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8247
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jan 2024 05:29:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14475

--_004_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_
Content-Type: multipart/alternative;
	boundary="_000_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_"

--_000_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Chris,

Sorry I forgot to attach the job definition using which you can understand =
where I am using those commands sent in the previous mail. Please have a lo=
ok and let me know your thoughts.

Thanks and regards,
Sai Ashrith ( T S I P )

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Monday, January 29, 2024 10:53 AM
To: 'Chris Paterson' <Chris.Paterson2@renesas.com>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com>; venkata1.pyla <venkata1.pyla@toshibaap.onmicrosoft.com>; kunij=
adar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.Kunijadar@t=
oshiba-tsip.com>; balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balak=
umar@toshiba-tsip.com>; sanglikar zaiba(=1B$B#T#S#I#P=1B(B TEUR) <Zaiba.San=
glikar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; hayashi kazuhiro(=
=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B$B!{#D#I#G""#M#P#S!{#M#P#4=
=1B(B) <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Chris,

Thank you for suggesting this scenario.

Yes, if we cancel the job in between, then both the swtpm process as well a=
s the .swtpm directory which we created in the beginning will remain causin=
g the later jobs to fail. So, we need to add killing the process as well as=
 removing the directory as part of undo action to some command which we wil=
l run at the beginning of the job. I don=1B$B!G=1B(Bt think it is possible =
to add more than one command as undo action to a command in LAVA. So, to ke=
ep it simple, let us include two small scripts in any directory you prefer =
in the slave machine. One script will start the tpm after checking if any s=
wtpm process is not running already and the other will make sure that whate=
ver the case, there should be no presence of swtpm process running as well =
as the temporary directory we created to store TPM state files. I did not a=
dd the swtpm_finish.sh as part of undo action of start_tpm because we need =
to use start_tpm twice in Swupdate related job definitions.

I am attaching the scripts, updated device dictionaries as well as the job =
definition in which we can use them. Please have a look at them.

Thanks and Regards,
Sai Ashrith ( T S I P )

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Thursday, January 25, 2024 7:53 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; venkata1.pyla <venkata1.=
pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicrosoft.c=
om>>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.=
Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>>; b=
alakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-tsip.c=
om<mailto:Adithya.Balakumar@toshiba-tsip.com>>; sanglikar zaiba(=1B$B#T#S#I=
#P=1B(B TEUR) <Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@tosh=
iba-tsip.com>>; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.cip-proj=
ect.org>; hayashi kazuhiro(=1B$BNS=1B(B =1B$BOB9(=1B(B =1B$B#D#M#E=1B(B =1B=
$B!{#D#I#G""#M#P#S!{#M#P#4=1B(B) <kazuhiro3.hayashi@toshiba.co.jp<mailto:ka=
zuhiro3.hayashi@toshiba.co.jp>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Sai,

Thank you for the information. It looks like you=1B$B!G=1B(Bre making good =
progress.

Your new approach seems pretty good to me, although one though=1B$B!D=1B(B
What happens if a job fails or is cancelled before reaching the end =1B$B!H=
=1B(Brm_tpmdir=1B$B!I=1B(B and =1B$B!H=1B(Bkill_tpm=1B$B!I=1B(B commands?
Wouldn=1B$B!G=1B(Bt the original swtpm instance set up by =1B$B!H=1B(Bstart=
_tpm=1B$B!I=1B(B keep running? And any subsequent jobs would end up in the =
infinite while loop in your script.
Is there a way to make it so that a command action is _always_ run at the e=
nd of a job?

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Tuesday, January 23, 2024 5:04 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ve=
nkata1.pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicr=
osoft.com>; Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar=
@toshiba-tsip.com>; Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balak=
umar@toshiba-tsip.com>; Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sangl=
ikar@toshiba-tsip.com>; cip-dev@lists.cip-project.org<mailto:cip-dev@lists.=
cip-project.org>; kazuhiro3.hayashi@toshiba.co.jp<mailto:kazuhiro3.hayashi@=
toshiba.co.jp>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Chris,

Please provide your opinion regarding the changes proposed in the below mai=
l.

Thanks and Regards,
Sai Ashrith (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Friday, January 19, 2024 12:46 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; 'venkata1.pyla' <venkata=
1.pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicrosoft=
.com>>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanan=
d.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>>;=
 balakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-tsip=
.com<mailto:Adithya.Balakumar@toshiba-tsip.com>>; sanglikar zaiba(=1B$B#T#S=
#I#P=1B(B TEUR) <Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@to=
shiba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Chris,

We investigated further more about this issue you pointed out where two job=
s using swtpm run at a similar time on the same dispatcher. I agree with yo=
ur opinion that it is not ideal and maintainable if we try to use different=
 variables for each qemu device template. So we came up with another approa=
ch.

As per my understanding, swtpm package is installed in lab-cip-renesas slav=
e right, so for now let us consider just using the qemu-01-renesas and qemu=
-02-renesas  devices to run the jobs which use swtpm related job definition=
s. Since there are only 2 qemu devices currently, we can use locking mechan=
ism to force the second job ( the one which was started later ) to wait unt=
il the first one is completely done with removal of .swtpm  directory as we=
ll killing that process. Once we confirm this in the script, only then the =
second job will start swtpm socket.

We measured the approximate time a full software update testing job can tak=
e and I will take care of that with the command action timeout considering =
the worst case wait time. I revised the user-commands in the device diction=
aries considering how the software update scenario can be tested successful=
ly using the security image. So I removed adding killing and removing swtpm=
 as undo actions and instead added them as do action. To give you a better =
understanding for why I did this, please have a look at the job definition =
I have attached in which I  demonstrated how multiple reboots can be handle=
d with this kind of image running with a swtpm socket.

I also attached another file where I put the script to be present in LAVA d=
ispatcher and the QEMU device dictionaries (same for both qemu-01-renesas a=
nd qemu-02-renesas).

Please provide your feedback on the above mentioned approach Chris.

Thanks and Regards,
Sai Ashrith (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Thursday, January 18, 2024 3:34 AM
To: 'Chris Paterson' <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; venkata1.pyla <venkata1.=
pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicrosoft.c=
om>>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.=
Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>>; b=
alakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-tsip.c=
om<mailto:Adithya.Balakumar@toshiba-tsip.com>>; sanglikar zaiba(=1B$B#T#S#I=
#P=1B(B TEUR) <Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@tosh=
iba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Chris,

Thank you for identifying this scenario.

Yes, if two swupdate jobs runs on two devices on the same dispatcher, the l=
atter will fail if needs to reboot again after the first job is done. The r=
eason is the UNIXIO socket will be gone after the client closed the connect=
ion.
Here there are two problems,


  1.  The .swtpm file names should be different or else there will be TPM f=
ailures. I tried to resolve this ways which does not have us hardcoding the=
 directory paths in each device template. For example, I tried to generate =
random strings using $RANDOM in the script, so that they don=1B$B!G=1B(Bt h=
ave to hardcoded in the templates. But then the problem will be, ------  Ho=
w will we delete the directory after the job if cant send the name back to =
the template.

So after some trials, I made the following changes to the device templates =
and the script to handle the naming problem of .swtpm file. I am attaching =
the new changes to this mail. Please have a look at those changes.


  1.  Since the /tmp/qemu-swtpm.sock UNIXIO socket is gone after one of the=
 jobs is done, we can try to make this individual for each device just like=
 how we did for .swtpm directory. But now the problem will be, ---------- H=
ow will use the correct path for the character device in the boot arguments=
 if it depends on the QEMU device. I tried to add a condition in the device=
 template specific to the jobs which include security targets as mentioned =
below.



{% if =1B$B!F=1B(Blava_test_results_dir=1B$B!G=1B(B =3D=3D =1B$B!F=1B(B/hom=
e/lava-%s %}

          - -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-01.sock

{% endif %}



  1.  I used it like above because I was not able to find any context which=
 narrow down to our jobs where we are using a read-only file system (That i=
s why I changed the directory into /home). But still the character device b=
oot arguments are not updated while running the test job. Please correct me=
 if I was wrong.


  1.  Based on my investigation today, I think handling the test jobs using=
 these TPM based images simultaneously shall require independent variables =
for each device. But as you said before, it might not be ideal to setup and=
 maintain.


Please provide your opinion on this and please suggest anything that I can =
try which can resolve the issue in point 2 mentioned above.

Thanks and Regards,
Sai Ashrith ( T S I P )

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Wednesday, January 17, 2024 7:26 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; venkata1.pyla <venkata1.=
pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicrosoft.c=
om>>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.=
Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>>; b=
alakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-tsip.c=
om<mailto:Adithya.Balakumar@toshiba-tsip.com>>; sanglikar zaiba(=1B$B#T#S#I=
#P=1B(B TEUR) <Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@tosh=
iba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Sai,

Thank you for the update.

If I understand it correctly, when you run swtpm_start.sh, the /var/lib/lav=
a/dispatcher/tmp/cip-core-security.swtpm file will be created.
And then when the job is finished, the undo command will be run and this fi=
le will be removed.
Sounds good.

However, this location is generic to ALL jobs run on that LAVA dispatcher.
So, if you had a SW Update test job running on two boards connected to the =
same LAVA dispatcher at the same time, we could have a case where the cip-c=
ore-security.swtpm file either gets corrupted by a second LAVA job trying t=
o use it at the same time, or we could face an issue where the first job de=
letes the file before the second has finished with it.

Is it possible to use the swtpm socket with multiple devices at the same ti=
me?
Or is it a 1to1 relationship?
If the latter, then we can keep the current approach, but we need to someho=
w use a different cip-core-security.swtpm file for each running job.

Are you planning to add the create_swtpm_tmpdir to the device template for =
each individual device? Or only to the device-type definitions? Are there a=
ny other places this can be defined?
If we are planning to add it to each individual device template, we could j=
ust use a different filename for each of them. Not ideal to setup & maintai=
n though.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Tuesday, January 16, 2024 12:40 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ve=
nkata1.pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicr=
osoft.com>; Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar=
@toshiba-tsip.com>; Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balak=
umar@toshiba-tsip.com>; Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sangl=
ikar@toshiba-tsip.com>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Chris,

Hope you are doing well.
I locally tested some configurations required to start the swtpm before boo=
ting the CIP security image and I am able to boot the image.


When we include swtpm socket -t -d --tpmstate dir=3D"${SWTPM_DIR}" --ctrl t=
ype=3Dunixio,path=3D/tmp/qemu-swtpm.sock --tpm2, it does not return value 0=
. And until the command run in the LAVA dispatcher does not return a value,=
 the job will stuck leading to a timeout. So to handle this we can do it ju=
st like how it is implemented in isar-cip-core i.e by putting it in an if-c=
ondition. Please have a look at this code snippet.
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/start-q=
emu.sh?ref_type=3Dheads#L173

But we cannot define a script inside {% set user_commands =3D %}, qemu-**.j=
inja2 template. So instead we can create a swtpm_start.sh script with a+x p=
ermissions in LAVA slave container and append the below configurations in t=
he qemu jinja2 device templates in the LAVA server.

{% set user_commands =3D {'create_swtpm_tmpdir': {'do': 'sh /home/swtpm_sta=
rt.sh',
                                             'undo': 'rm -rf /var/lib/lava/=
dispatcher/tmp/cip-core-security.swtpm'}} %}

We can add the below bash script in swtpm_start.sh

#!/bin/sh

mkdir -p /var/lib/lava/dispatcher/tmp/cip-core-security.swtpm

if swtpm socket -d --tpmstate dir=3D"/var/lib/lava/dispatcher/tmp/cip-core-=
security.swtpm" \
                         --ctrl type=3Dunixio,path=3D/tmp/qemu-swtpm.sock \
                         --tpm2; then
        echo $?
fi


Please provide your feedback on the above approach Chris.

Thanks and regards,
Sai Ashrith

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Thursday, January 4, 2024 5:58 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; venkata1.pyla <venkata1.=
pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicrosoft.c=
om>>; kunijadar shivanand(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <Shivanand.=
Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>>; b=
alakumar adithya(=1B$B#T#S#I#P=1B(B TEUR) <Adithya.Balakumar@toshiba-tsip.c=
om<mailto:Adithya.Balakumar@toshiba-tsip.com>>; sanglikar zaiba(=1B$B#T#S#I=
#P=1B(B TEUR) <Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@tosh=
iba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Sai,

I=1B$B!G=1B(Bve had a look.

For option 1), we could have done it if we had a way of knowing the LAVA Jo=
b number when we run the command, however from what I=1B$B!G=1B(Bve experim=
ented with we don=1B$B!G=1B(Bt.
We could create a directory with =1B$B!F=1B(Bdo=1B$B!G=1B(B and remove it w=
ith =1B$B!F=1B(Bundo=1B$B!G=1B(B, however the directory would need to be un=
ique to avoid clashes.
If we were to add our custom command individually to every device dictionar=
y we could do this, but it would be easier to maintain if we only added the=
 commend to the device type dictionaries.

For option 2), wouldn=1B$B!G=1B(Bt we face a similar issue? The TPM_PATH va=
riable would need to be set with a unique value for each test run before th=
e job starts.

Wouldn=1B$B!G=1B(Bt we need to stop the TPM emulator once a job has complet=
ed?

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Wednesday, January 3, 2024 7:25 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; ve=
nkata1.pyla@toshibaap.onmicrosoft.com<mailto:venkata1.pyla@toshibaap.onmicr=
osoft.com>; Shivanand.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar=
@toshiba-tsip.com>; Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balak=
umar@toshiba-tsip.com>; Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sangl=
ikar@toshiba-tsip.com>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hi Chris,

I was able to access OVMF related files in my job definitions in qemu-devic=
es in =1B$B!H=1B(Blab-renesas-cip=1B$B!I=1B(B. Now let me explain the curre=
nt situation while starting the tpm emulator using swtpm.

We need to run this command right before we boot the image to start the TPM=
 emulator --> swtpm socket -d --tpmstate dir=3D"${SWTPM_DIR}" --ctrl type=
=3Dunixio,path=3D/tmp/qemu-swtpm.sock --tpm2


  1.  A directory must be created to store the TPM state files before we ru=
n this command. I doubt if there is a way to create a temporary directory i=
n this path /var/lib/lava/dispatcher/tmp/<job_id>/, so that it can be clear=
ed automatically when the entire test job is done.

(OR)


  1.  An environment variable named TPM_PATH must be updated with the direc=
tory path to store the TPM state files.

If you think that method 2 is favorable, then I request you to add swtpm so=
cket -d  --ctrl type=3Dunixio,path=3D/tmp/qemu-swtpm.sock --tpm2 in the =1B=
$B!H=1B(Bdo=1B$B!I=1B(B section in the device dictionary. I don=1B$B!G=1B(B=
t think anything needs to be added in the =1B$B!H=1B(Bundo
section Chris.

I apologize for asking many questions Chris. Please provide your opinion on=
 the above query.

Thanks and Regards,
Sai Ashrith (T S I P)

From: ashrith sai(=1B$B#T#S#I#P=1B(B)
Sent: Tuesday, January 2, 2024 6:03 PM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; Venkata.Pyla@toshiba-tsi=
p.com<mailto:Venkata.Pyla@toshiba-tsip.com>; kunijadar shivanand(=1B$B#T#S#=
I#P=1B(B TMIEC ODG Porting) <Shivanand.Kunijadar@toshiba-tsip.com<mailto:Sh=
ivanand.Kunijadar@toshiba-tsip.com>>; balakumar adithya(=1B$B#T#S#I#P=1B(B =
TEUR) <Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balakumar@toshiba-=
tsip.com>>; sanglikar zaiba(=1B$B#T#S#I#P=1B(B TEUR) <Zaiba.Sanglikar@toshi=
ba-tsip.com<mailto:Zaiba.Sanglikar@toshiba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hi Chris,

Thanks for your support.

I will try and let you know if I face any issues and about updating the dev=
ice dictionary as well as soon as possible Chris. Before that I will do som=
e sample testing to confirm some things.

Thanks and Regards,
Sai Ashrith

From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Tuesday, January 2, 2024 5:47 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; Venkata.Pyla@toshiba-tsi=
p.com<mailto:Venkata.Pyla@toshiba-tsip.com>; kunijadar shivanand(=1B$B#T#S#=
I#P=1B(B TMIEC ODG Porting) <Shivanand.Kunijadar@toshiba-tsip.com<mailto:Sh=
ivanand.Kunijadar@toshiba-tsip.com>>; balakumar adithya(=1B$B#T#S#I#P=1B(B =
TEUR) <Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balakumar@toshiba-=
tsip.com>>; sanglikar zaiba(=1B$B#T#S#I#P=1B(B TEUR) <Zaiba.Sanglikar@toshi=
ba-tsip.com<mailto:Zaiba.Sanglikar@toshiba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Sai,

As I=1B$B!G=1B(Bm in the office today, I can=1B$B!G=1B(Bt update my lab at =
home.
Instead I=1B$B!G=1B(Bve installed the swtpm and ovmf packages into lab-rene=
sas-cip.

I=1B$B!G=1B(Bve marked the qemu devices in lab-renesas-cip with the =1B$B!H=
=1B(Bsw-update-testing=1B$B!I=1B(B tag.
So if you add the below to your job definition, the job will only run on on=
e of the qemu devices in the Renesas lab:

tags:

- sw-update-testing

Please give it a try and let me know if you have any issues.

Let me know if you need me to update the device dictionary as well.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Tuesday, January 2, 2024 11:25 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; Ve=
nkata.Pyla@toshiba-tsip.com<mailto:Venkata.Pyla@toshiba-tsip.com>; Shivanan=
d.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>; =
Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balakumar@toshiba-tsip.co=
m>; Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@toshiba-tsip.co=
m>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Chris,

Thanks for your reply.

Including swtpm and ovmf packages is necessary for test cases related to se=
cure boot, software update and IEC layer testing. Please let me finalize th=
e linux command I have mentioned in this mailing thread.
It will be very helpful if this command is available for qemu device in you=
r LAVA lab. Please tell me how I can access your LAVA lab in which I can ru=
n my sample test jobs.

Thanks and Regards,
Sai Ashrith


From: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@re=
nesas.com>>
Sent: Tuesday, January 2, 2024 4:29 PM
To: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com<mailto:=
Sai.Sathujoda@toshiba-tsip.com>>
Cc: dinesh kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshib=
a-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>>; Venkata.Pyla@toshiba-tsi=
p.com<mailto:Venkata.Pyla@toshiba-tsip.com>; kunijadar shivanand(=1B$B#T#S#=
I#P=1B(B TMIEC ODG Porting) <Shivanand.Kunijadar@toshiba-tsip.com<mailto:Sh=
ivanand.Kunijadar@toshiba-tsip.com>>; balakumar adithya(=1B$B#T#S#I#P=1B(B =
TEUR) <Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balakumar@toshiba-=
tsip.com>>; sanglikar zaiba(=1B$B#T#S#I#P=1B(B TEUR) <Zaiba.Sanglikar@toshi=
ba-tsip.com<mailto:Zaiba.Sanglikar@toshiba-tsip.com>>
Subject: RE: Query - ( Running Linux commands in LAVA host before booting t=
he image )

Hello Sai,

I think using the =1B$B!H=1B(Bcommand=1B$B!I=1B(B action is probably the be=
st approach.
Does the command you want to run ever change? Or is it the same for every t=
est job and for every platform?

We=1B$B!G=1B(Bll have to make sure that the lava-docker container we use in=
cludes the swtpm and ovmf packages, then get all of the labs updated.
We can get a quick(er) test run using my lab though if it helps you.

Kind regards, Chris

From: Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>=
 <Sai.Sathujoda@toshiba-tsip.com<mailto:Sai.Sathujoda@toshiba-tsip.com>>
Sent: Thursday, December 21, 2023 4:19 AM
To: Chris Paterson <Chris.Paterson2@renesas.com<mailto:Chris.Paterson2@rene=
sas.com>>
Cc: dinesh.kumar@toshiba-tsip.com<mailto:dinesh.kumar@toshiba-tsip.com>; Ve=
nkata.Pyla@toshiba-tsip.com<mailto:Venkata.Pyla@toshiba-tsip.com>; Shivanan=
d.Kunijadar@toshiba-tsip.com<mailto:Shivanand.Kunijadar@toshiba-tsip.com>; =
Adithya.Balakumar@toshiba-tsip.com<mailto:Adithya.Balakumar@toshiba-tsip.co=
m>; Zaiba.Sanglikar@toshiba-tsip.com<mailto:Zaiba.Sanglikar@toshiba-tsip.co=
m>
Subject: Query - ( Running Linux commands in LAVA host before booting the i=
mage )

Dear Chris,

Currently we are working on running IEC layer tests present in https://gitl=
ab.com/cip-project/cip-testing/cip-security-tests on CIP security image. As=
 you might be aware, current security image has secure boot, swupdate and D=
ata encryption features also enabled along with security layer.
So to boot this image, we need to run the below command just before booting=
 the image to start TPM emulator.

swtpm socket -d --tpmstate dir=3D"${SWTPM_DIR}"  --ctrl type=3Dunixio,path=
=3D/tmp/qemu-swtpm.sock  --tpm2

Our current requirements:


  1.  Presence of these packages in LAVA host environment --> swtpm, ovmf
  2.  Ability to run the above mentioned in the LAVA host before the first =
boot action.

After going through the LAVA documentation, I found an action named command=
 where we can run commands on the dispatcher itself. --> https://lava.readt=
hedocs.io/en/latest/technical-references/job-definition/actions/command/#:~=
:text=3DThe%20command%20action%20is%20used,board%20by%20controlling%20a%20r=
elay.

But they are suggesting that these commands need to be added in the device =
dictionary in CIP LAVA server so that users can just use the name of the co=
mmand ( key ) in their job definition. Please correct me if my understandin=
g is wrong. And also can you please suggest if there is any other way to ru=
n Linux commands in the LAVA host environment.

Note: We are using qemu device for this job definition.

Thanks and Regards,
Sai Ashrith


--_000_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_
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
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"MS Gothic";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"MS PGothic";
	panose-1:2 11 6 0 7 2 5 8 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@MS PGothic";}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@MS Gothic";
	panose-1:2 11 6 9 7 2 5 8 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:ZH-CN;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";
	mso-fareast-language:ZH-CN;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;
	mso-fareast-language:ZH-CN;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";}
span.CodeChar
	{mso-style-name:"Code Char";
	mso-style-link:Code;
	font-family:"Courier New";}
p.Code, li.Code, div.Code
	{mso-style-name:Code;
	mso-style-link:"Code Char";
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Courier New";
	mso-ligatures:standardcontextual;
	mso-fareast-language:ZH-CN;}
span.EmailStyle25
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
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
	{mso-list-id:652952996;
	mso-list-type:hybrid;
	mso-list-template-ids:-2085351714 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:774129814;
	mso-list-type:hybrid;
	mso-list-template-ids:-1391560522 67698703 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1388602276;
	mso-list-type:hybrid;
	mso-list-template-ids:516600232 67698703 67698713 67698715 67698703 676987=
13 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
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
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sorry I f=
orgot to attach the job definition using which you can understand where I a=
m using those commands sent in the previous mail. Please have a look and le=
t me know your thoughts.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA">From:</span></b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA"> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B=
$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-languag=
e:JA">)
<br>
<b>Sent:</b> Monday, January 29, 2024 10:53 AM<br>
<b>To:</b> 'Chris Paterson' &lt;Chris.Paterson2@renesas.com&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-lang=
uage:JA"> TMIEC ODG Porting) &lt;dinesh.kumar@toshiba-tsip.com&gt;; venkata=
1.pyla
 &lt;venkata1.pyla@toshibaap.onmicrosoft.com&gt;; kunijadar shivanand(</spa=
n><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;=
mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span =
style=3D"mso-ligatures:none;mso-fareast-language:JA"> TMIEC ODG Porting)
 &lt;Shivanand.Kunijadar@toshiba-tsip.com&gt;; balakumar adithya(</span><sp=
an lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-l=
igatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span style=
=3D"mso-ligatures:none;mso-fareast-language:JA"> TEUR) &lt;Adithya.Balakuma=
r@toshiba-tsip.com&gt;;
 sanglikar zaiba(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGo=
thic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S=
#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-language:JA">=
 TEUR) &lt;Zaiba.Sanglikar@toshiba-tsip.com&gt;; cip-dev@lists.cip-project.=
org;
 hayashi kazuhiro(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PG=
othic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$BNS=
=1B(B</span><span lang=3D"JA" style=3D"mso-ligatures:none;mso-fareast-langu=
age:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$BOB9(=1B(B</span><span=
 lang=3D"JA" style=3D"mso-ligatures:none;mso-fareast-language:JA">
</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-s=
erif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#D#M#E=1B(B</span><sp=
an style=3D"mso-ligatures:none;mso-fareast-language:JA"> =1B$B!{=1B(B</span=
><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;m=
so-ligatures:none;mso-fareast-language:JA">=1B$B#D#I#G=1B(B</span><span sty=
le=3D"mso-ligatures:none;mso-fareast-language:JA">=1B$B""=1B(B</span><span =
lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-liga=
tures:none;mso-fareast-language:JA">=1B$B#M#P#S=1B(B</span><span style=3D"m=
so-ligatures:none;mso-fareast-language:JA">=1B$B!{=1B(B</span><span lang=3D=
"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:n=
one;mso-fareast-language:JA">=1B$B#M#P#4=1B(B</span><span style=3D"mso-liga=
tures:none;mso-fareast-language:JA">)
 &lt;kazuhiro3.hayashi@toshiba.co.jp&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thank you=
 for suggesting this scenario.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Yes, if w=
e cancel the job in between, then both the swtpm process as well as the .sw=
tpm directory which we created in the beginning will remain causing the lat=
er jobs to fail. So, we need to add
 killing the process as well as removing the directory as part of undo acti=
on to some command which we will run at the beginning of the job. I don=1B$=
B!G=1B(Bt think it is possible to add more than one command as undo action =
to a command in LAVA. So, to keep it simple,
 let us include two small scripts in any directory you prefer in the slave =
machine. One script will start the tpm after checking if any swtpm process =
is not running already and the other will make sure that whatever the case,=
 there should be no presence of
 swtpm process running as well as the temporary directory we created to sto=
re TPM state files. I did not add the
<b>swtpm_finish.sh </b>as part of undo action of <b>start_tpm </b>because w=
e need to use start_tpm twice in Swupdate related job definitions.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I am atta=
ching the scripts, updated device dictionaries as well as the job definitio=
n in which we can use them. Please have a look at them.<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th ( T S I P )<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;<a href=3D"mailto:=
Chris.Paterson2@renesas.com">Chris.Paterson2@renesas.com</a>&gt;
<br>
<b>Sent:</b> Thursday, January 25, 2024 7:53 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-CN" style=3D"font-family:Sim=
Sun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none">) &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathuj=
oda@toshiba-tsip.com</a>&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-CN" style=3D"font-family:Si=
mSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatu=
res:none"> TMIEC ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-ts=
ip.com">dinesh.kumar@toshiba-tsip.com</a>&gt;; venkata1.pyla
 &lt;<a href=3D"mailto:venkata1.pyla@toshibaap.onmicrosoft.com">venkata1.py=
la@toshibaap.onmicrosoft.com</a>&gt;; kunijadar shivanand(</span><span lang=
=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=1B=
(B</span><span style=3D"mso-ligatures:none"> TMIEC ODG Porting)
 &lt;<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com">Shivanand.Kuni=
jadar@toshiba-tsip.com</a>&gt;; balakumar adithya(</span><span lang=3D"ZH-C=
N" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span=
><span style=3D"mso-ligatures:none"> TEUR) &lt;<a href=3D"mailto:Adithya.Ba=
lakumar@toshiba-tsip.com">Adithya.Balakumar@toshiba-tsip.com</a>&gt;;
 sanglikar zaiba(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;ms=
o-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:non=
e"> TEUR) &lt;<a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com">Zaiba.San=
glikar@toshiba-tsip.com</a>&gt;;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a>; hayashi kazuhiro(</span><span lang=3D"ZH-CN" style=3D"font-family:=
SimSun;mso-ligatures:none">=1B$BNS=1B(B</span><span lang=3D"ZH-CN" style=3D=
"mso-ligatures:none">
</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none"=
>=1B$BOB9(=1B(B</span><span lang=3D"ZH-CN" style=3D"mso-ligatures:none">
</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none"=
>=1B$B#D#M#E=1B(B</span><span style=3D"mso-ligatures:none"> =1B$B!{=1B(B</s=
pan><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=
=1B$B#D#I#G=1B(B</span><span style=3D"mso-ligatures:none">=1B$B""=1B(B</spa=
n><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$=
B#M#P#S=1B(B</span><span style=3D"mso-ligatures:none">=1B$B!{=1B(B</span><s=
pan lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#M#=
P#4=1B(B</span><span style=3D"mso-ligatures:none">)
 &lt;<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@t=
oshiba.co.jp</a>&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Thank you for =
the information. It looks like you=1B$B!G=1B(Bre making good progress.<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Your new appro=
ach seems pretty good to me, although one though=1B$B!D=1B(B<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">What happens i=
f a job fails or is cancelled before reaching the end =1B$B!H=1B(Brm_tpmdir=
=1B$B!I=1B(B and =1B$B!H=1B(Bkill_tpm=1B$B!I=1B(B commands?<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Wouldn=1B$B!G=
=1B(Bt the original swtpm instance set up by =1B$B!H=1B(Bstart_tpm=1B$B!I=
=1B(B keep running? And any subsequent jobs would end up in the infinite wh=
ile loop
 in your script.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Is there a way=
 to make it so that a command action is _<i>always</i>_ run at the end of a=
 job?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN=
-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujoda@toshiba-tsi=
p.com</a> &lt;<a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com">Sai.Sathujo=
da@toshiba-tsip.com</a>&gt;
<br>
<b>Sent:</b> Tuesday, January 23, 2024 5:04 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> <a href=3D"mailto:dinesh.kumar@toshiba-tsip.com">dinesh.kumar@to=
shiba-tsip.com</a>;
<a href=3D"mailto:venkata1.pyla@toshibaap.onmicrosoft.com">venkata1.pyla@to=
shibaap.onmicrosoft.com</a>;
<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com">Shivanand.Kunijadar=
@toshiba-tsip.com</a>;
<a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com">Adithya.Balakumar@tos=
hiba-tsip.com</a>;
<a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com">Zaiba.Sanglikar@toshiba=
-tsip.com</a>;
<a href=3D"mailto:cip-dev@lists.cip-project.org">cip-dev@lists.cip-project.=
org</a>;
<a href=3D"mailto:kazuhiro3.hayashi@toshiba.co.jp">kazuhiro3.hayashi@toshib=
a.co.jp</a><br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Please provide your opinion regarding the c=
hanges proposed in the below mail.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Sai Ashrith (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA">From:</span></b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA"> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B=
$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-languag=
e:JA">)
<br>
<b>Sent:</b> Friday, January 19, 2024 12:46 AM<br>
<b>To:</b> Chris Paterson &lt;<a href=3D"mailto:Chris.Paterson2@renesas.com=
">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-lang=
uage:JA"> TMIEC ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsi=
p.com">dinesh.kumar@toshiba-tsip.com</a>&gt;;
 'venkata1.pyla' &lt;<a href=3D"mailto:venkata1.pyla@toshibaap.onmicrosoft.=
com">venkata1.pyla@toshibaap.onmicrosoft.com</a>&gt;; kunijadar shivanand(<=
/span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><s=
pan style=3D"mso-ligatures:none;mso-fareast-language:JA">
 TMIEC ODG Porting) &lt;<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.=
com">Shivanand.Kunijadar@toshiba-tsip.com</a>&gt;; balakumar adithya(</span=
><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;m=
so-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span s=
tyle=3D"mso-ligatures:none;mso-fareast-language:JA">
 TEUR) &lt;<a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com">Adithya.Ba=
lakumar@toshiba-tsip.com</a>&gt;; sanglikar zaiba(</span><span lang=3D"JA" =
style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;m=
so-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none;mso-fareast-language:JA">
 TEUR) &lt;<a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com">Zaiba.Sangli=
kar@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">We investigated further more about this iss=
ue you pointed out where two jobs using swtpm run at a similar time on the =
same dispatcher. I agree with your opinion that
 it is not ideal and maintainable if we try to use different variables for =
each qemu device template. So we came up with another approach.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">As per my understanding, swtpm package is i=
nstalled in lab-cip-renesas slave right, so for now let us consider just us=
ing the
<b>qemu-01-renesas </b>and <b>qemu-02-renesas </b>&nbsp;devices to run the =
jobs which use swtpm related job definitions. Since there are only 2 qemu d=
evices currently, we can use locking mechanism to force the second job ( th=
e one which was started later ) to wait
 until the first one is completely done with removal of .swtpm &nbsp;direct=
ory as well killing that process. Once we confirm this in the script, only =
then the second job will start swtpm socket.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">We measured the approximate time a full sof=
tware update testing job can take and I will take care of that with the com=
mand action timeout considering the worst case
 wait time. I revised the user-commands in the device dictionaries consider=
ing how the software update scenario can be tested successfully using the s=
ecurity image. So I removed adding killing and removing swtpm as undo actio=
ns and instead added them as do
 action. To give you a better understanding for why I did this, please have=
 a look at the job definition I have attached in which I&nbsp; demonstrated=
 how multiple reboots can be handled with this kind of image running with a=
 swtpm socket.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">I also attached another file where I put th=
e script to be present in LAVA dispatcher and the QEMU device dictionaries =
(same for both qemu-01-renesas and qemu-02-renesas).<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Please provide your feedback on the above m=
entioned approach Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Sai Ashrith (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA">From:</span></b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA"> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B=
$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-languag=
e:JA">)
<br>
<b>Sent:</b> Thursday, January 18, 2024 3:34 AM<br>
<b>To:</b> 'Chris Paterson' &lt;<a href=3D"mailto:Chris.Paterson2@renesas.c=
om">Chris.Paterson2@renesas.com</a>&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-lang=
uage:JA"> TMIEC ODG Porting) &lt;<a href=3D"mailto:dinesh.kumar@toshiba-tsi=
p.com">dinesh.kumar@toshiba-tsip.com</a>&gt;;
 venkata1.pyla &lt;<a href=3D"mailto:venkata1.pyla@toshibaap.onmicrosoft.co=
m">venkata1.pyla@toshibaap.onmicrosoft.com</a>&gt;; kunijadar shivanand(</s=
pan><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-seri=
f;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><spa=
n style=3D"mso-ligatures:none;mso-fareast-language:JA">
 TMIEC ODG Porting) &lt;<a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.=
com">Shivanand.Kunijadar@toshiba-tsip.com</a>&gt;; balakumar adithya(</span=
><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;m=
so-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span s=
tyle=3D"mso-ligatures:none;mso-fareast-language:JA">
 TEUR) &lt;<a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com">Adithya.Ba=
lakumar@toshiba-tsip.com</a>&gt;; sanglikar zaiba(</span><span lang=3D"JA" =
style=3D"font-family:&quot;MS PGothic&quot;,sans-serif;mso-ligatures:none;m=
so-fareast-language:JA">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none;mso-fareast-language:JA">
 TEUR) &lt;<a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com">Zaiba.Sangli=
kar@toshiba-tsip.com</a>&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Thank you for identifying this scenario.<o:=
p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Yes, if two swupdate jobs runs on two devic=
es on the same dispatcher, the latter will fail if needs to reboot again af=
ter the first job is done. The reason is the UNIXIO
 socket will be gone after the client closed the connection. <o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Here there are two problems,<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-l=
anguage:EN-US">The .swtpm file names should be different or else there will=
 be TPM failures. I tried to resolve this ways which
 does not have us hardcoding the directory paths in each device template. F=
or example, I tried to generate random strings using $RANDOM in the script,=
 so that they don=1B$B!G=1B(Bt have to hardcoded in the templates. But then=
 the problem will be, ------ &nbsp;How will we delete
 the directory after the job if cant send the name back to the template.<o:=
p></o:p></span></li></ol>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Aptos&quot;,=
sans-serif;mso-fareast-language:EN-US">So after some trials, I made the fol=
lowing changes to the device templates and the script to handle the naming =
problem of .swtpm file. I am attaching the new
 changes to this mail. Please have a look at those changes.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-l=
anguage:EN-US">Since the /tmp/qemu-swtpm.sock UNIXIO socket is gone after o=
ne of the jobs is done, we can try to make this
 individual for each device just like how we did for .swtpm directory. But =
now the problem will be, ---------- How will use the correct path for the c=
haracter device in the boot arguments if it depends on the QEMU device. I t=
ried to add a condition in the device
 template specific to the jobs which include security targets as mentioned =
below.<o:p></o:p></span></li></ol>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Aptos&quot;,=
sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Courier New&=
quot;;mso-fareast-language:EN-US">{% if =1B$B!F=1B(Blava_test_results_dir=
=1B$B!G=1B(B =3D=3D =1B$B!F=1B(B/home/lava-%s %}<o:p></o:p></span></p>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Courier New&=
quot;;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; - -chardev socket,id=3Dchrtpm,path=3D/tmp/qemu-01.sock<o:p></=
o:p></span></p>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Courier New&=
quot;;mso-fareast-language:EN-US">{% endif %}<o:p></o:p></span></p>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Courier New&=
quot;;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"3" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-l=
anguage:EN-US">I used it like above because I was not able to find any cont=
ext which narrow down to our jobs where we are using
 a read-only file system (That is why I changed the directory into /home). =
But still the character device boot arguments are not updated while running=
 the test job. Please correct me if I was wrong.<o:p></o:p></span></li></ol=
>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"4" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l0 level1 =
lfo1"><span style=3D"font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-l=
anguage:EN-US">Based on my investigation today, I think handling the test j=
obs using these TPM based images simultaneously
 shall require independent variables for each device. But as you said befor=
e, it might not be ideal to setup and maintain.<o:p></o:p></span></li></ol>
<p class=3D"MsoListParagraph"><span style=3D"font-family:&quot;Aptos&quot;,=
sans-serif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Please provide your opinion on this and ple=
ase suggest anything that I can try which can resolve the issue in point 2 =
mentioned above.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Thanks and Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Sai Ashrith ( T S I P )<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;</span><a href=3D"=
mailto:Chris.Paterson2@renesas.com"><span style=3D"mso-ligatures:none">Chri=
s.Paterson2@renesas.com</span></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Wednesday, January 17, 2024 7:26 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-CN" style=3D"font-family:Sim=
Sun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none">) &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-CN" style=3D"font-family:Si=
mSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatu=
res:none"> TMIEC ODG Porting) &lt;</span><a href=3D"mailto:dinesh.kumar@tos=
hiba-tsip.com"><span style=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip=
.com</span></a><span style=3D"mso-ligatures:none">&gt;;
 venkata1.pyla &lt;</span><a href=3D"mailto:venkata1.pyla@toshibaap.onmicro=
soft.com"><span style=3D"mso-ligatures:none">venkata1.pyla@toshibaap.onmicr=
osoft.com</span></a><span style=3D"mso-ligatures:none">&gt;; kunijadar shiv=
anand(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures=
:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">
 TMIEC ODG Porting) &lt;</span><a href=3D"mailto:Shivanand.Kunijadar@toshib=
a-tsip.com"><span style=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-=
tsip.com</span></a><span style=3D"mso-ligatures:none">&gt;; balakumar adith=
ya(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:no=
ne">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></=
a><span style=3D"mso-ligatures:none">&gt;; sanglikar zaiba(</span><span lan=
g=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span=
 style=3D"mso-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Hello Sai,<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Thank you for =
the update.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">If I understan=
d it correctly, when you run swtpm_start.sh, the
</span><span class=3D"CodeChar"><span lang=3D"EN-GB" style=3D"mso-fareast-l=
anguage:EN-US">/var/lib/lava/dispatcher/tmp/cip-core-security.swtpm</span><=
/span><span lang=3D"EN-GB" style=3D"font-family:&quot;Aptos&quot;,sans-seri=
f;color:#7030A0;mso-fareast-language:EN-US"> file will
 be created.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">And then when =
the job is finished, the undo command will be run and this file will be rem=
oved.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Sounds good.<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">However, this =
location is generic to ALL jobs run on that LAVA dispatcher.<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">So, if you had=
 a SW Update test job running on two boards connected to the same LAVA disp=
atcher at the same time, we could have a case where
 the </span><span class=3D"CodeChar"><span lang=3D"EN-GB" style=3D"mso-fare=
ast-language:EN-US">cip-core-security.swtpm</span></span><span lang=3D"EN-G=
B" style=3D"font-family:&quot;Aptos&quot;,sans-serif;color:#7030A0;mso-fare=
ast-language:EN-US"> file either gets corrupted by a
 second LAVA job trying to use it at the same time, or we could face an iss=
ue where the first job deletes the file before the second has finished with=
 it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Is it possible=
 to use the swtpm socket with multiple devices at the same time?<o:p></o:p>=
</span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Or is it a 1to=
1 relationship?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">If the latter,=
 then we can keep the current approach, but we need to somehow use a differ=
ent
</span><span class=3D"CodeChar"><span lang=3D"EN-GB" style=3D"mso-fareast-l=
anguage:EN-US">cip-core-security.swtpm</span></span><span lang=3D"EN-GB" st=
yle=3D"font-family:&quot;Aptos&quot;,sans-serif;color:#7030A0;mso-fareast-l=
anguage:EN-US"> file for each running job.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">Are you planni=
ng to add the
</span><span class=3D"CodeChar"><span lang=3D"EN-GB" style=3D"mso-fareast-l=
anguage:EN-US">create_swtpm_tmpdir</span></span><span lang=3D"EN-GB" style=
=3D"font-family:&quot;Aptos&quot;,sans-serif;color:#7030A0;mso-fareast-lang=
uage:EN-US"> to the device template for each individual
 device? Or only to the device-type definitions? Are there any other places=
 this can be defined?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US">If we are plan=
ning to add it to each individual device template, we could just use a diff=
erent filename for each of them. Not ideal to setup
 &amp; maintain though.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-ligatures:none;mso-fareast-language:EN=
-GB">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"font-family:&quot;Apto=
s&quot;,sans-serif;color:#7030A0;mso-fareast-language:EN-US"><o:p>&nbsp;</o=
:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"mso=
-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"ms=
o-ligatures:none"> &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.=
com"><span style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</spa=
n></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Tuesday, January 16, 2024 12:40 PM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"mso-ligatures:none">Chris.Paterson2@renesas.com</sp=
an></a><span style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span st=
yle=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip.com</span></a><span st=
yle=3D"mso-ligatures:none">;
</span><a href=3D"mailto:venkata1.pyla@toshibaap.onmicrosoft.com"><span sty=
le=3D"mso-ligatures:none">venkata1.pyla@toshibaap.onmicrosoft.com</span></a=
><span style=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com"><span style=
=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-tsip.com</span></a><spa=
n style=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><span style=3D=
"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></a><span sty=
le=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span style=3D"m=
so-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><span style=
=3D"mso-ligatures:none"><br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Hello Chris,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">Hope you are doing well.<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">I locally tested some configurations requir=
ed to start the swtpm before booting the CIP security image and I am able t=
o boot the image.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<pre><span style=3D"font-family:&quot;Aptos&quot;,sans-serif">When we inclu=
de </span>swtpm socket -t -d --tpmstate dir=3D&quot;${SWTPM_DIR}&quot; --ct=
rl type=3Dunixio,path=3D/tmp/qemu-swtpm.sock --tpm2, <span style=3D"font-si=
ze:11.0pt;font-family:&quot;Aptos&quot;,sans-serif">it does not return valu=
e 0. And until the command run in the LAVA dispatcher does not return a val=
ue, the job will stuck leading to a timeout. So to handle this we can do it=
 just like how it is implemented in isar-cip-core i.e by putting it in an i=
f-condition. Please have a look at this code snippet.<o:p></o:p></span></pr=
e>
<p class=3D"MsoNormal"><a href=3D"https://gitlab.com/cip-project/cip-core/i=
sar-cip-core/-/blob/master/start-qemu.sh?ref_type=3Dheads#L173"><span style=
=3D"font-family:&quot;Aptos&quot;,sans-serif;mso-fareast-language:EN-US">ht=
tps://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/start-qem=
u.sh?ref_type=3Dheads#L173</span></a><span style=3D"font-family:&quot;Aptos=
&quot;,sans-serif;mso-fareast-language:EN-US"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US">But we cannot define a script inside
</span><span style=3D"font-family:&quot;Courier New&quot;">{% set user_comm=
ands =3D %}, </span>
<span style=3D"font-family:&quot;Aptos&quot;,sans-serif">qemu-**.jinja2 tem=
plate. So instead we can create a swtpm_start.sh script with a+x permission=
s in LAVA slave container and append the below configurations in the qemu j=
inja2 device templates in the LAVA server.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">{% set user_commands =3D {'cr=
eate_swtpm_tmpdir': {'do': 'sh /home/swtpm_start.sh',</span><span style=3D"=
font-family:&quot;Aptos&quot;,sans-serif;mso-ligatures:none;mso-fareast-lan=
guage:EN-US">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;'undo': 'rm -rf /var/lib/lava/dispatcher/tmp/cip-core-secur=
ity.swtpm'}} %}</span><span style=3D"font-family:&quot;Aptos&quot;,sans-ser=
if;mso-ligatures:none;mso-fareast-language:EN-US">
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US">We can add the below bas=
h script in
<b>swtpm_start.sh</b><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">#!/bin/sh<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">mkdir -p /var/lib/lava/dispat=
cher/tmp/cip-core-security.swtpm<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">if swtpm socket -d --tpmstate=
 dir=3D&quot;/var/lib/lava/dispatcher/tmp/cip-core-security.swtpm&quot; \<o=
:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --ctrl type=3Dunixio,path=3D/tmp/q=
emu-swtpm.sock \<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; --tpm2; then<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; echo $?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US">fi<o:p></o:p></span></p>
<div style=3D"border:none;border-bottom:solid windowtext 1.0pt;padding:0in =
0in 1.0pt 0in">
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Courier New&quot;;m=
so-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US">Please provide your feed=
back on the above approach Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US">Thanks and regards,<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-ligatures:none;mso-fareast-language:EN-US">Sai Ashrith<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-family:&quot;Aptos&quot;,sans-se=
rif;mso-fareast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;</span><a href=3D"=
mailto:Chris.Paterson2@renesas.com"><span style=3D"mso-ligatures:none">Chri=
s.Paterson2@renesas.com</span></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Thursday, January 4, 2024 5:58 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-CN" style=3D"font-family:Sim=
Sun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none">) &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-CN" style=3D"font-family:Si=
mSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatu=
res:none"> TMIEC ODG Porting) &lt;</span><a href=3D"mailto:dinesh.kumar@tos=
hiba-tsip.com"><span style=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip=
.com</span></a><span style=3D"mso-ligatures:none">&gt;;
 venkata1.pyla &lt;</span><a href=3D"mailto:venkata1.pyla@toshibaap.onmicro=
soft.com"><span style=3D"mso-ligatures:none">venkata1.pyla@toshibaap.onmicr=
osoft.com</span></a><span style=3D"mso-ligatures:none">&gt;; kunijadar shiv=
anand(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures=
:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">
 TMIEC ODG Porting) &lt;</span><a href=3D"mailto:Shivanand.Kunijadar@toshib=
a-tsip.com"><span style=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-=
tsip.com</span></a><span style=3D"mso-ligatures:none">&gt;; balakumar adith=
ya(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:no=
ne">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></=
a><span style=3D"mso-ligatures:none">&gt;; sanglikar zaiba(</span><span lan=
g=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span=
 style=3D"mso-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Hello Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">I=1B$B!G=1B(Bve had a look.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">For option 1), we could have done it if we had a way of=
 knowing the LAVA Job number when we run the command, however from what I=
=1B$B!G=1B(Bve experimented with we don=1B$B!G=1B(Bt.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">We could create a directory with =1B$B!F=1B(Bdo=1B$B!G=
=1B(B and remove it with =1B$B!F=1B(Bundo=1B$B!G=1B(B, however the director=
y would need to be unique to avoid clashes.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">If we were to add our custom command individually to ev=
ery device dictionary we could do this, but it would be easier to maintain =
if we only added the commend to the device
 type dictionaries.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">For option 2), wouldn=1B$B!G=1B(Bt we face a similar is=
sue? The TPM_PATH variable would need to be set with a unique value for eac=
h test run before the job starts.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Wouldn=1B$B!G=1B(Bt we need to stop the TPM emulator on=
ce a job has completed?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"mso=
-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"ms=
o-ligatures:none"> &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.=
com"><span style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</spa=
n></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Wednesday, January 3, 2024 7:25 AM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"mso-ligatures:none">Chris.Paterson2@renesas.com</sp=
an></a><span style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span st=
yle=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip.com</span></a><span st=
yle=3D"mso-ligatures:none">;
</span><a href=3D"mailto:venkata1.pyla@toshibaap.onmicrosoft.com"><span sty=
le=3D"mso-ligatures:none">venkata1.pyla@toshibaap.onmicrosoft.com</span></a=
><span style=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com"><span style=
=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-tsip.com</span></a><spa=
n style=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><span style=3D=
"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></a><span sty=
le=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span style=3D"m=
so-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><span style=
=3D"mso-ligatures:none"><br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I was abl=
e to access OVMF related files in my job definitions in qemu-devices in =1B=
$B!H=1B(Blab-renesas-cip=1B$B!I=1B(B. Now let me explain the current situat=
ion while starting the tpm emulator using swtpm<b>.<o:p></o:p></b></span></=
p>
<p class=3D"MsoNormal"><b><span style=3D"mso-fareast-language:EN-US"><o:p>&=
nbsp;</o:p></span></b></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">We need t=
o run this command right before we boot the image to start the TPM emulator
</span><span style=3D"font-family:Wingdings;mso-fareast-language:EN-US">&ag=
rave;</span><span style=3D"mso-fareast-language:EN-US">
<b>swtpm socket -d --tpmstate dir=3D&quot;${SWTPM_DIR}&quot; --ctrl type=3D=
unixio,path=3D/tmp/qemu-swtpm.sock --tpm2<o:p></o:p></b></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2"><span style=3D"mso-fareast-language:EN-US">A directory must be create=
d to store the TPM state files before we run this command. I doubt if there=
 is a way to create a temporary directory
 in this path </span><span style=3D"font-size:9.5pt;font-family:Consolas;co=
lor:black;background:#F9F2F4">/var/lib/lava/dispatcher/tmp/&lt;job_id&gt;/<=
/span><span style=3D"mso-fareast-language:EN-US">, so that it can be cleare=
d automatically when the entire test job is
 done.<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">(OR)<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<ol style=3D"margin-top:0in" start=3D"2" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo2"><span style=3D"mso-fareast-language:EN-US">An environment variable na=
med TPM_PATH must be updated with the directory path to store the TPM state=
 files.<o:p></o:p></span></li></ol>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">If you th=
ink that method 2 is favorable, then I request you to add
<b>swtpm socket -d &nbsp;--ctrl type=3Dunixio,path=3D/tmp/qemu-swtpm.sock -=
-tpm2 </b>in the =1B$B!H=1B(Bdo=1B$B!I=1B(B section in the device dictionar=
y. I don=1B$B!G=1B(Bt think anything needs to be added in the =1B$B!H=1B(Bu=
ndo<br>
section Chris.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I apologi=
ze for asking many questions Chris. Please provide your opinion on the abov=
e query.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th (T S I P)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA">From:</span></b><span style=3D"mso-ligatures:none;mso-fareast-lan=
guage:JA"> ashrith sai(</span><span lang=3D"JA" style=3D"font-family:&quot;=
MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B=
$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-languag=
e:JA">)
<br>
<b>Sent:</b> Tuesday, January 2, 2024 6:03 PM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"mso-ligatures:none;mso-fareast-language:JA">Chris.P=
aterson2@renesas.com</span></a><span style=3D"mso-ligatures:none;mso-fareas=
t-language:JA">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"JA" style=3D"font-family:&quot=
;MS PGothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=
=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-lang=
uage:JA"> TMIEC ODG Porting) &lt;</span><a href=3D"mailto:dinesh.kumar@tosh=
iba-tsip.com"><span style=3D"mso-ligatures:none;mso-fareast-language:JA">di=
nesh.kumar@toshiba-tsip.com</span></a><span style=3D"mso-ligatures:none;mso=
-fareast-language:JA">&gt;;
</span><a href=3D"mailto:Venkata.Pyla@toshiba-tsip.com"><span style=3D"mso-=
ligatures:none;mso-fareast-language:JA">Venkata.Pyla@toshiba-tsip.com</span=
></a><span style=3D"mso-ligatures:none;mso-fareast-language:JA">; kunijadar=
 shivanand(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGothic&q=
uot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S#I#P=
=1B(B</span><span lang=3D"JA" style=3D"mso-ligatures:none;mso-fareast-langu=
age:JA">
</span><span style=3D"mso-ligatures:none;mso-fareast-language:JA">TMIEC ODG=
 Porting) &lt;</span><a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com=
"><span style=3D"mso-ligatures:none;mso-fareast-language:JA">Shivanand.Kuni=
jadar@toshiba-tsip.com</span></a><span style=3D"mso-ligatures:none;mso-fare=
ast-language:JA">&gt;;
 balakumar adithya(</span><span lang=3D"JA" style=3D"font-family:&quot;MS P=
Gothic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T=
#S#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-language:JA=
"> TEUR) &lt;</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><=
span style=3D"mso-ligatures:none;mso-fareast-language:JA">Adithya.Balakumar=
@toshiba-tsip.com</span></a><span style=3D"mso-ligatures:none;mso-fareast-l=
anguage:JA">&gt;;
 sanglikar zaiba(</span><span lang=3D"JA" style=3D"font-family:&quot;MS PGo=
thic&quot;,sans-serif;mso-ligatures:none;mso-fareast-language:JA">=1B$B#T#S=
#I#P=1B(B</span><span style=3D"mso-ligatures:none;mso-fareast-language:JA">=
 TEUR) &lt;</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span=
 style=3D"mso-ligatures:none;mso-fareast-language:JA">Zaiba.Sanglikar@toshi=
ba-tsip.com</span></a><span style=3D"mso-ligatures:none;mso-fareast-languag=
e:JA">&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hi Chris,=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks fo=
r your support.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">I will tr=
y and let you know if I face any issues and about updating the device dicti=
onary as well as soon as possible Chris. Before that I will do some sample =
testing to confirm some things.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;</span><a href=3D"=
mailto:Chris.Paterson2@renesas.com"><span style=3D"mso-ligatures:none">Chri=
s.Paterson2@renesas.com</span></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Tuesday, January 2, 2024 5:47 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-CN" style=3D"font-family:Sim=
Sun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none">) &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-CN" style=3D"font-family:Si=
mSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatu=
res:none"> TMIEC ODG Porting) &lt;</span><a href=3D"mailto:dinesh.kumar@tos=
hiba-tsip.com"><span style=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip=
.com</span></a><span style=3D"mso-ligatures:none">&gt;;
</span><a href=3D"mailto:Venkata.Pyla@toshiba-tsip.com"><span style=3D"mso-=
ligatures:none">Venkata.Pyla@toshiba-tsip.com</span></a><span style=3D"mso-=
ligatures:none">; kunijadar shivanand(</span><span lang=3D"ZH-CN" style=3D"=
font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=
=3D"mso-ligatures:none">
 TMIEC ODG Porting) &lt;</span><a href=3D"mailto:Shivanand.Kunijadar@toshib=
a-tsip.com"><span style=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-=
tsip.com</span></a><span style=3D"mso-ligatures:none">&gt;; balakumar adith=
ya(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:no=
ne">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></=
a><span style=3D"mso-ligatures:none">&gt;; sanglikar zaiba(</span><span lan=
g=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span=
 style=3D"mso-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Hello Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">As I=1B$B!G=1B(Bm in the office today, I can=1B$B!G=1B(=
Bt update my lab at home.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Instead I=1B$B!G=1B(Bve installed the swtpm and ovmf pa=
ckages into lab-renesas-cip.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">I=1B$B!G=1B(Bve marked the qemu devices in lab-renesas-=
cip with the =1B$B!H=1B(Bsw-update-testing=1B$B!I=1B(B tag.<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">So if you add the below to your job definition, the job=
 will only run on one of the qemu devices in the Renesas lab:<o:p></o:p></s=
pan></p>
<p class=3D"Code"><span lang=3D"EN-GB" style=3D"mso-fareast-language:EN-US"=
>tags:<o:p></o:p></span></p>
<p class=3D"Code"><span lang=3D"EN-GB" style=3D"mso-fareast-language:EN-US"=
>- sw-update-testing<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Please give it a try and let me know if you have any is=
sues.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Let me know if you need me to update the device diction=
ary as well.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none;mso-fareast-language:EN-GB">Kind regards, Chris<o:p></o:p></span=
></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"mso=
-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"ms=
o-ligatures:none"> &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.=
com"><span style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</spa=
n></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Tuesday, January 2, 2024 11:25 AM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"mso-ligatures:none">Chris.Paterson2@renesas.com</sp=
an></a><span style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span st=
yle=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip.com</span></a><span st=
yle=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Venkata.Pyla@toshiba-tsip.com"><span style=3D"mso-=
ligatures:none">Venkata.Pyla@toshiba-tsip.com</span></a><span style=3D"mso-=
ligatures:none">;
</span><a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com"><span style=
=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-tsip.com</span></a><spa=
n style=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><span style=3D=
"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></a><span sty=
le=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span style=3D"m=
so-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><span style=
=3D"mso-ligatures:none"><br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Hello Chr=
is,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks fo=
r your reply.
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Including=
 swtpm and ovmf packages is necessary for test cases related to secure boot=
, software update and IEC layer testing. Please let me finalize the linux c=
ommand I have mentioned in this mailing
 thread.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">It will b=
e very helpful if this command is available for qemu device in your LAVA la=
b. Please tell me how I can access your LAVA lab in which I can run my samp=
le test jobs.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Thanks an=
d Regards,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US">Sai Ashri=
th<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"mso-fareast-language:EN-US"><o:p>&nbs=
p;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none"> Chris Paterson &lt;</span><a href=3D"=
mailto:Chris.Paterson2@renesas.com"><span style=3D"mso-ligatures:none">Chri=
s.Paterson2@renesas.com</span></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Tuesday, January 2, 2024 4:29 PM<br>
<b>To:</b> ashrith sai(</span><span lang=3D"ZH-CN" style=3D"font-family:Sim=
Sun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatur=
es:none">) &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> dinesh kumar(</span><span lang=3D"ZH-CN" style=3D"font-family:Si=
mSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatu=
res:none"> TMIEC ODG Porting) &lt;</span><a href=3D"mailto:dinesh.kumar@tos=
hiba-tsip.com"><span style=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip=
.com</span></a><span style=3D"mso-ligatures:none">&gt;;
</span><a href=3D"mailto:Venkata.Pyla@toshiba-tsip.com"><span style=3D"mso-=
ligatures:none">Venkata.Pyla@toshiba-tsip.com</span></a><span style=3D"mso-=
ligatures:none">; kunijadar shivanand(</span><span lang=3D"ZH-CN" style=3D"=
font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=1B(B</span><span style=
=3D"mso-ligatures:none">
 TMIEC ODG Porting) &lt;</span><a href=3D"mailto:Shivanand.Kunijadar@toshib=
a-tsip.com"><span style=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-=
tsip.com</span></a><span style=3D"mso-ligatures:none">&gt;; balakumar adith=
ya(</span><span lang=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:no=
ne">=1B$B#T#S#I#P=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><sp=
an style=3D"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></=
a><span style=3D"mso-ligatures:none">&gt;; sanglikar zaiba(</span><span lan=
g=3D"ZH-CN" style=3D"font-family:SimSun;mso-ligatures:none">=1B$B#T#S#I#P=
=1B(B</span><span style=3D"mso-ligatures:none">
 TEUR) &lt;</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span=
 style=3D"mso-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><s=
pan style=3D"mso-ligatures:none">&gt;<br>
<b>Subject:</b> RE: Query - ( Running Linux commands in LAVA host before bo=
oting the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Hello Sai,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">I think using the =1B$B!H=1B(Bcommand=1B$B!I=1B(B actio=
n is probably the best approach.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">Does the command you want to run ever change? Or is it =
the same for every test job and for every platform?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">We=1B$B!G=1B(Bll have to make sure that the lava-docker=
 container we use includes the swtpm and ovmf packages, then get all of the=
 labs updated.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US">We can get a quick(er) test run using my lab though if =
it helps you.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-liga=
tures:none">Kind regards, Chris<o:p></o:p></span></p>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB" style=3D"color:#7030A0;mso-fare=
ast-language:EN-US"><o:p>&nbsp;</o:p></span></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"mso-ligatures:none">From:</span></=
b><span style=3D"mso-ligatures:none">
</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.com"><span style=3D"mso=
-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</span></a><span style=3D"ms=
o-ligatures:none"> &lt;</span><a href=3D"mailto:Sai.Sathujoda@toshiba-tsip.=
com"><span style=3D"mso-ligatures:none">Sai.Sathujoda@toshiba-tsip.com</spa=
n></a><span style=3D"mso-ligatures:none">&gt;
<br>
<b>Sent:</b> Thursday, December 21, 2023 4:19 AM<br>
<b>To:</b> Chris Paterson &lt;</span><a href=3D"mailto:Chris.Paterson2@rene=
sas.com"><span style=3D"mso-ligatures:none">Chris.Paterson2@renesas.com</sp=
an></a><span style=3D"mso-ligatures:none">&gt;<br>
<b>Cc:</b> </span><a href=3D"mailto:dinesh.kumar@toshiba-tsip.com"><span st=
yle=3D"mso-ligatures:none">dinesh.kumar@toshiba-tsip.com</span></a><span st=
yle=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Venkata.Pyla@toshiba-tsip.com"><span style=3D"mso-=
ligatures:none">Venkata.Pyla@toshiba-tsip.com</span></a><span style=3D"mso-=
ligatures:none">;
</span><a href=3D"mailto:Shivanand.Kunijadar@toshiba-tsip.com"><span style=
=3D"mso-ligatures:none">Shivanand.Kunijadar@toshiba-tsip.com</span></a><spa=
n style=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Adithya.Balakumar@toshiba-tsip.com"><span style=3D=
"mso-ligatures:none">Adithya.Balakumar@toshiba-tsip.com</span></a><span sty=
le=3D"mso-ligatures:none">;
</span><a href=3D"mailto:Zaiba.Sanglikar@toshiba-tsip.com"><span style=3D"m=
so-ligatures:none">Zaiba.Sanglikar@toshiba-tsip.com</span></a><span style=
=3D"mso-ligatures:none"><br>
<b>Subject:</b> Query - ( Running Linux commands in LAVA host before bootin=
g the image )<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><span lang=3D"EN-GB"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal">Dear Chris,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Currently we are working on running IEC layer tests =
present in
<a href=3D"https://gitlab.com/cip-project/cip-testing/cip-security-tests">h=
ttps://gitlab.com/cip-project/cip-testing/cip-security-tests</a> on CIP sec=
urity image. As you might be aware, current security image has
<b>secure boot</b>, <b>swupdate</b> and <b>Data encryption</b> features als=
o enabled along with security layer.<o:p></o:p></p>
<p class=3D"MsoNormal">So to boot this image, we need to run the below comm=
and just before booting the image to start TPM emulator.
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>swtpm socket -d --tpmstate dir=3D&quot;${SWTPM_DI=
R}&quot; &nbsp;--ctrl type=3Dunixio,path=3D/tmp/qemu-swtpm.sock &nbsp;--tpm=
2<o:p></o:p></b></p>
<p class=3D"MsoNormal"><b><o:p>&nbsp;</o:p></b></p>
<p class=3D"MsoNormal">Our current requirements:<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 level1 =
lfo3">Presence of these packages in LAVA host environment
<span style=3D"font-family:Wingdings">&agrave;</span> swtpm, ovmf<o:p></o:p=
></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l2 l=
evel1 lfo3">Ability to run the above mentioned in the LAVA host before the =
first boot action.<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">After going through the LAVA documentation, I found =
an action named command where we can run commands on the dispatcher itself.
<span style=3D"font-family:Wingdings">&agrave;</span> <a href=3D"https://la=
va.readthedocs.io/en/latest/technical-references/job-definition/actions/com=
mand/#:~:text=3DThe%20command%20action%20is%20used,board%20by%20controlling=
%20a%20relay">
https://lava.readthedocs.io/en/latest/technical-references/job-definition/a=
ctions/command/#:~:text=3DThe%20command%20action%20is%20used,board%20by%20c=
ontrolling%20a%20relay</a>.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">But they are suggesting that these commands need to =
be added in the device dictionary in CIP LAVA server so that users can just=
 use the name of the command ( key ) in their job definition. Please correc=
t me if my understanding is wrong.
 And also can you please suggest if there is any other way to run Linux com=
mands in the LAVA host environment.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b>Note: </b>We are using qemu device for this job d=
efinition.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks and Regards, <o:p></o:p></p>
<p class=3D"MsoNormal">Sai Ashrith<o:p></o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</div>
</div>
</div>
</div>
</div>
</body>
</html>

--_000_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_--

--_004_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_
Content-Type: text/plain; name="rebootjobdefinition_swtpm.txt"
Content-Description: rebootjobdefinition_swtpm.txt
Content-Disposition: attachment; filename="rebootjobdefinition_swtpm.txt";
	size=3088; creation-date="Mon, 29 Jan 2024 05:26:52 GMT";
	modification-date="Mon, 29 Jan 2024 05:28:52 GMT"
Content-Transfer-Encoding: base64

ZGV2aWNlX3R5cGU6IHFlbXUNCmpvYl9uYW1lOiBxZW11IHg4Nl82NCByZWJvb3QgdGVzdGluZyAo
Q0lQIHNlY3VyaXR5IGltYWdlKQ0KdGltZW91dHM6DQogIGpvYjoNCiAgICBtaW51dGVzOiAyMA0K
ICBhY3Rpb246DQogICBtaW51dGVzOiAxMA0KICBhY3Rpb25zOg0KICAgIHBvd2VyLW9mZjoNCiAg
ICAgIHNlY29uZHM6IDYwDQpwcmlvcml0eTogaGlnaA0KdmlzaWJpbGl0eTogcGVyc29uYWwNCm5v
dGlmeToNCiAgY3JpdGVyaWE6DQogICAgc3RhdHVzOiBmaW5pc2hlZA0KICByZWNpcGllbnRzOg0K
ICAtIHRvOg0KICAgICBtZXRob2Q6IGVtYWlsDQogICAgIGVtYWlsOiBzYWkuc2F0aHVqb2RhQHRv
c2hpYmEtdHNpcC5jb20NCmNvbnRleHQ6DQogIGFyY2g6IHg4Nl82NA0KICBsYXZhX3Rlc3RfZGly
OiAnL2hvbWUvbGF2YS0lcycNCiANCiMgQk9PVCBCTE9DSw0KDQojIEFDVElPTiBCTE9DSw0KYWN0
aW9uczoNCg0KIC0gY29tbWFuZDoNCiAgICBuYW1lOiBzdXJlX2tpbGwNCiAgICB0aW1lb3V0Og0K
ICAgICAgICAgIG1pbnV0ZXM6IDEgDQoNCi0gY29tbWFuZDoNCiAgICBuYW1lOiBzdGFydF90cG0N
CiAgICB0aW1lb3V0Og0KICAgICAgICAgIG1pbnV0ZXM6IDIwDQoNCi0gZGVwbG95Og0KICAgIHRp
bWVvdXQ6DQogICAgICBtaW51dGVzOiAxNQ0KICAgIHRvOiB0bXBmcw0KICAgIGltYWdlczoNCiAg
ICAgIHN5c3RlbToNCiAgICAgICAgaW1hZ2VfYXJnOiAnLWRyaXZlIGZpbGU9e3N5c3RlbX0sZGlz
Y2FyZD11bm1hcCxpZj1ub25lLGlkPWRpc2ssZm9ybWF0PXJhdyAtbSAxRyAtc2VyaWFsIG1vbjpz
dGRpbyAtY3B1IHFlbXU2NCAgLXNtcCA0IC1tYWNoaW5lIHEzNSxhY2NlbD10Y2cgIC1nbG9iYWwg
SUNIOS1MUEMubm9yZWJvb3Q9b2ZmIC1kZXZpY2UgaWRlLWhkLGRyaXZlPWRpc2sgLWRyaXZlIGlm
PXBmbGFzaCxmb3JtYXQ9cmF3LHVuaXQ9MCxyZWFkb25seT1vbixmaWxlPS91c3Ivc2hhcmUvT1ZN
Ri9PVk1GX0NPREVfNE0uc2VjYm9vdC5mZCAtZHJpdmUgaWY9cGZsYXNoLGZvcm1hdD1yYXcscmVh
ZG9ubHk9b24sZmlsZT0vdXNyL3NoYXJlL09WTUYvT1ZNRl9WQVJTXzRNLnNuYWtlb2lsLmZkICAt
Z2xvYmFsIElDSDktTFBDLmRpc2FibGVfczM9MSAtZ2xvYmFsIGlzYS1mZGMuZHJpdmVBPSAtbm9n
cmFwaGljIC1jaGFyZGV2IHNvY2tldCxpZD1jaHJ0cG0scGF0aD0vdG1wL3FlbXUtc3d0cG0uc29j
ayAtdHBtZGV2IGVtdWxhdG9yLGlkPXRwbTAsY2hhcmRldj1jaHJ0cG0gLWRldmljZSB0cG0tdGlz
LHRwbWRldj10cG0wJw0KICAgICAgICB1cmw6IGh0dHBzOi8vczMuZXUtY2VudHJhbC0xLmFtYXpv
bmF3cy5jb20vZG93bmxvYWQyLmNpcC1wcm9qZWN0Lm9yZy9jaXAtY29yZS9zYWktbGF2YS1pZWMt
dGVzdGluZy9xZW11LWFtZDY0L2NpcC1jb3JlLWltYWdlLXNlY3VyaXR5LWNpcC1jb3JlLWJvb2t3
b3JtLXFlbXUtYW1kNjQud2ljLnh6DQogICAgICAgIGNvbXByZXNzaW9uOiB4eg0KDQotIGJvb3Q6
DQogICAgdGltZW91dDoNCiAgICAgIG1pbnV0ZXM6IDEwDQogICAgbWV0aG9kOiBxZW11DQogICAg
bWVkaWE6IHRtcGZzDQogICAgcHJvbXB0czogWyJyb290QGRlbW86fiMiXQ0KICAgIGF1dG9fbG9n
aW46DQogICAgICBsb2dpbl9wcm9tcHQ6ICJkZW1vIGxvZ2luOiINCiAgICAgIHVzZXJuYW1lOiAi
cm9vdCINCiAgICAgIHBhc3N3b3JkX3Byb21wdDogIlBhc3N3b3JkOiINCiAgICAgIHBhc3N3b3Jk
OiAiQ0lQc2VjdXJpdHlAMTIzIg0KDQojIFRFU1RfQkxPQ0sNCi0gdGVzdDoNCiAgICAgdGltZW91
dDoNCiAgICAgICBtaW51dGVzOiA1DQogICAgIGRlZmluaXRpb25zOg0KICAgICAtIHJlcG9zaXRv
cnk6DQogICAgICAgICBtZXRhZGF0YToNCiAgICAgICAgICAgZm9ybWF0OiBMYXZhLVRlc3QgVGVz
dCBEZWZpbml0aW9uIDEuMA0KICAgICAgICAgICBuYW1lOiBzYW1wbGUtdGVzdC0xDQogICAgICAg
ICAgIGRlc2NyaXB0aW9uOiAiY2hlY2sgcmVib290IHZlcnNpb24iDQogICAgICAgICBydW46DQog
ICAgICAgICAgIHN0ZXBzOg0KICAgICAgICAgICAgIC0gbGF2YS10ZXN0LWNhc2UgdW5hbWUgLS1z
aGVsbCB1bmFtZSAtYQ0KICAgICAgICAgICAgIC0gbHNibGsNCiAgICAgICBmcm9tOiBpbmxpbmUN
CiAgICAgICBuYW1lOiBzYW1wbGUtdGVzdC0xDQogICAgICAgcGF0aDogaW5saW5lL3NhbXBsZS10
ZXN0LnlhbWwNCg0KLSBjb21tYW5kOg0KICAgIG5hbWU6IGtpbGxfdHBtDQogICAgdGltZW91dDoN
CiAgICAgICAgICBtaW51dGVzOiAyDQoNCi0gY29tbWFuZDoNCiAgICBuYW1lOiBzdGFydF90cG0N
CiAgICB0aW1lb3V0Og0KICAgICAgICAgIG1pbnV0ZXM6IDINCg0KLSBib290Og0KICAgIHRpbWVv
dXQ6DQogICAgICBtaW51dGVzOiAxMA0KICAgIG1ldGhvZDogcWVtdQ0KICAgIG1lZGlhOiB0bXBm
cw0KICAgIHByb21wdHM6IFsicm9vdEBkZW1vOn4jIl0NCiAgICBhdXRvX2xvZ2luOg0KICAgICAg
bG9naW5fcHJvbXB0OiAiZGVtbyBsb2dpbjoiDQogICAgICB1c2VybmFtZTogInJvb3QiDQogICAg
ICBwYXNzd29yZF9wcm9tcHQ6ICJQYXNzd29yZDoiDQogICAgICBwYXNzd29yZDogIkNJUHNlY3Vy
aXR5QDEyMyINCg0KIyBURVNUX0JMT0NLDQotIHRlc3Q6DQogICAgIHRpbWVvdXQ6DQogICAgICAg
bWludXRlczogNQ0KICAgICBkZWZpbml0aW9uczoNCiAgICAgLSByZXBvc2l0b3J5Og0KICAgICAg
ICAgbWV0YWRhdGE6DQogICAgICAgICAgIGZvcm1hdDogTGF2YS1UZXN0IFRlc3QgRGVmaW5pdGlv
biAxLjANCiAgICAgICAgICAgbmFtZTogc2FtcGxlLXRlc3QtMg0KICAgICAgICAgICBkZXNjcmlw
dGlvbjogImNoZWNrIHJlYm9vdCB2ZXJzaW9uIg0KICAgICAgICAgcnVuOg0KICAgICAgICAgICBz
dGVwczoNCiAgICAgICAgICAgICAtIGxhdmEtdGVzdC1jYXNlIHVuYW1lIC0tc2hlbGwgdW5hbWUg
LWENCiAgICAgICAgICAgICAtIGxzYmxrDQogICAgICAgZnJvbTogaW5saW5lDQogICAgICAgbmFt
ZTogc2FtcGxlLXRlc3QtMg0KICAgICAgIHBhdGg6IGlubGluZS9zYW1wbGUtdGVzdC55YW1sDQoN
CmNvbnRleHQ6DQogIGFyY2g6IHg4Nl82NA0KICBsYXZhX3Rlc3RfcmVzdWx0c19kaXI6ICcvaG9t
ZS9sYXZhLSVzJw==

--_004_OS3PR01MB6103ACBF54C0EB68AA65F93DC27E2OS3PR01MB6103jpnp_--


