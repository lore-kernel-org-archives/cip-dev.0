From: biju.das@bp.renesas.com (Biju Das)
Date: Wed, 17 Jul 2019 07:16:05 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add support
	for	NXP pcf85263 rtc
In-Reply-To: <OSAPR01MB3234ABFCA10DAC2E6D74289692C90@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <1563264921-42973-1-git-send-email-biju.das@bp.renesas.com>
	<1563264921-42973-6-git-send-email-biju.das@bp.renesas.com>
	<OSAPR01MB3234ABFCA10DAC2E6D74289692C90@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2103ED72F24A325F68299855B8C90@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Nobuhiro,

Thanks for the feedback.

> Subject: RE: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add support for
> NXP pcf85263 rtc
> 
> Hi,
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org
> > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> > Sent: Tuesday, July 16, 2019 5:15 PM
> > To: cip-dev at lists.cip-project.org
> > Cc: Biju Das <biju.das@bp.renesas.com>
> > Subject: [cip-dev] [PATCH 4.4.y-cip 05/10] rtc: pcf85363: Add support
> > for NXP pcf85263 rtc
> >
> > commit fc979933bcf162595b6004d0de4effb64c323152 upstream.
> >
> > Add support for NXP pcf85263 real-time clock. pcf85263 rtc is
> > compatible with pcf85363,except that pcf85363 has additional 64 bytes of
> RAM.
> >
> > 1 byte of nvmem is supported and exposed in sysfs (# is the instance
> > number,starting with 0): /sys/bus/nvmem/devices/pcf85x63-#/nvmem
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com> [ Removed rtc nvmem
> > support. Added I2C ID table for rtc-pcf85263 ]
> 
> You've deleted Alexandre's Signed-off-by tag from original patch.

Thanks for pointing this out. It is a mistake.  Can you please fix this while applying to the tree?

Or 

Do you want me to send another patch fixing this? Please let me know.

Regards,
Biju

[>] 
> > ---
> >  drivers/rtc/rtc-pcf85363.c | 40
> > ++++++++++++++++++++++++++++++++--------
> >  1 file changed, 32 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
> > index dc57a6f..64217f1 100644
> > --- a/drivers/rtc/rtc-pcf85363.c
> > +++ b/drivers/rtc/rtc-pcf85363.c
> > @@ -87,6 +87,11 @@ struct pcf85363 {
> >  	struct regmap		*regmap;
> >  };
> >
> > +struct pcf85x63_config {
> > +	struct regmap_config regmap;
> > +	unsigned int num_nvram;
> > +};
> > +
> >  static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time
> > *tm)  {
> >  	struct pcf85363 *pcf85363 = dev_get_drvdata(dev); @@ -148,16
> > +153,33 @@ static const struct rtc_class_ops rtc_ops = {
> >  	.set_time	= pcf85363_rtc_set_time,
> >  };
> >
> > -static const struct regmap_config regmap_config = {
> > -	.reg_bits = 8,
> > -	.val_bits = 8,
> > -	.max_register = 0x7f,
> > +static const struct pcf85x63_config pcf_85263_config = {
> > +	.regmap = {
> > +		.reg_bits = 8,
> > +		.val_bits = 8,
> > +		.max_register = 0x2f,
> > +	},
> > +	.num_nvram = 1
> > +};
> > +
> > +static const struct pcf85x63_config pcf_85363_config = {
> > +	.regmap = {
> > +		.reg_bits = 8,
> > +		.val_bits = 8,
> > +		.max_register = 0x7f,
> > +	},
> > +	.num_nvram = 2
> >  };
> >
> >  static int pcf85363_probe(struct i2c_client *client,
> >  			  const struct i2c_device_id *id)
> >  {
> >  	struct pcf85363 *pcf85363;
> > +	const struct pcf85x63_config *config = &pcf_85363_config;
> > +	const void *data = of_device_get_match_data(&client->dev);
> > +
> > +	if (data)
> > +		config = data;
> >
> >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> >  		return -ENODEV;
> > @@ -167,7 +189,7 @@ static int pcf85363_probe(struct i2c_client *client,
> >  	if (!pcf85363)
> >  		return -ENOMEM;
> >
> > -	pcf85363->regmap = devm_regmap_init_i2c(client,
> > &regmap_config);
> > +	pcf85363->regmap = devm_regmap_init_i2c(client,
> > &config->regmap);
> >  	if (IS_ERR(pcf85363->regmap)) {
> >  		dev_err(&client->dev, "regmap allocation failed\n");
> >  		return PTR_ERR(pcf85363->regmap);
> > @@ -185,12 +207,14 @@ static int pcf85363_probe(struct i2c_client
> > *client,
> >
> >  static const struct i2c_device_id pcf85363_id[] = {
> >  	{ "pcf85363", 0 },
> > +	{ "pcf85263", 0 },
> >  	{ }
> >  };
> >
> >  static const struct of_device_id dev_ids[] = {
> > -	{ .compatible = "nxp,pcf85363" },
> > -	{}
> > +	{ .compatible = "nxp,pcf85263", .data = &pcf_85263_config },
> > +	{ .compatible = "nxp,pcf85363", .data = &pcf_85363_config },
> > +	{ /* sentinel */ }
> >  };
> >  MODULE_DEVICE_TABLE(of, dev_ids);
> >
> > @@ -206,5 +230,5 @@ static struct i2c_driver pcf85363_driver = {
> > module_i2c_driver(pcf85363_driver);
> >
> >  MODULE_AUTHOR("Eric Nelson");
> > -MODULE_DESCRIPTION("pcf85363 I2C RTC driver");
> > +MODULE_DESCRIPTION("pcf85263/pcf85363 I2C RTC driver");
> >  MODULE_LICENSE("GPL");
> > --
> > 2.7.4
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
