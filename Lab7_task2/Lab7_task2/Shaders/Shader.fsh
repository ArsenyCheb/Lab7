//
//  Shader.fsh
//  Lab7_task2
//
//  Created by Arseny Cheb on 19.05.17.
//  Copyright © 2017 Arseny Cheb. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
