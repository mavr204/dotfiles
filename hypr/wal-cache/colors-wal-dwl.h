/* Taken from https://github.com/djpohly/dwl/issues/466 */
#define COLOR(hex)    { ((hex >> 24) & 0xFF) / 255.0f, \
                        ((hex >> 16) & 0xFF) / 255.0f, \
                        ((hex >> 8) & 0xFF) / 255.0f, \
                        (hex & 0xFF) / 255.0f }

static const float rootcolor[]             = COLOR(0x0e0c1eff);
static uint32_t colors[][3]                = {
	/*               fg          bg          border    */
	[SchemeNorm] = { 0xc2c2c6ff, 0x0e0c1eff, 0x5e5c70ff },
	[SchemeSel]  = { 0xc2c2c6ff, 0x5C7490ff, 0x32618Aff },
	[SchemeUrg]  = { 0xc2c2c6ff, 0x32618Aff, 0x5C7490ff },
};
