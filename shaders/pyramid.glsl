#version 320 es

// https://www.shadertoy.com/view/tsXBzS

precision highp float;
uniform float iTime;

vec3 palette(float d) {
    return mix(vec3(0.2, 0.7, 0.9), vec3(1., 0., 1.), d);
}

vec2 rotate(vec2 p, float a) {
    float c = cos(a);
    float s = sin(a);
    return p * mat2(c, s, -s, c);
}

float map(vec3 p) {
    for(float i = 0.0; i < 8.0; ++i) {
        float t = iTime * 0.2;
        p.xz = rotate(p.xz, t);
        p.xy = rotate(p.xy, t * 1.89);
        p.xz = abs(p.xz);
        p.xz -= .5;
    }
    return dot(sign(p), p) / 5.0;
}

vec4 rm(vec3 ro, vec3 rd) {
    float t = 0.;
    vec3 col = vec3(0.0);
    float d = 0.0;
    for(float i = 0.0; i < 64.0; i++) {
        vec3 p = ro + rd * t;
        d = map(p) * .5;
        if(d < 0.02) {
            break;
        }
        if(d > 100.) {
            break;
        }
        //col+=vec3(0.6,0.8,0.8)/(400.*(d));
        col += palette(length(p) * .1) / (400. * d);
        t += d;
    }
    return vec4(col, 1. / (d * 100.));
}

vec4 fragment(in vec2 uV, in vec2 fragCoord) {
    vec2 uv = (fragCoord - (resolution.xy / 2.)) / resolution.x;
    vec3 ro = vec3(0., 0., -50.);
    ro.xz = rotate(ro.xz, iTime);
    vec3 cf = normalize(-ro);
    vec3 cs = normalize(cross(cf, vec3(0., 1., 0.)));
    vec3 cu = normalize(cross(cf, cs));

    vec3 uuv = ro + cf * 3. + uv.x * cs + uv.y * cu;

    vec3 rd = normalize(uuv - ro);

    vec4 col = rm(ro, rd);

    return col;
}